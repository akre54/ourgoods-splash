class SignupsController < ApplicationController
  def new
    @signup = Signup.new
    @signup.have = Barterable.new
    @signup.need = Barterable.new
  end

  def create
    valid_params = signup_params
    @signup = Signup.new valid_params

    @signup.have = Barterable.find_or_create_by valid_params[:have_attributes]
    @signup.need = Barterable.find_or_create_by valid_params[:need_attributes]

    if @signup.save
      session[:signup_id] = @signup.id
      redirect_to success_path
    else
      flash.now[:error] = @signup.errors.full_messages
      render 'signups/new', status: :unprocessable_entity
    end
  end

  def success
    redirect_to new_signup_path unless session[:signup_id]

    @signup = Signup.find session[:signup_id]
    session[:signup_id] = nil
  end

private
  def signup_params
    params.require(:signup).permit(:email, :name, have_attributes: :description, need_attributes: :description)
  end
end
