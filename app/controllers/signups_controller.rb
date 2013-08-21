class SignupsController < ApplicationController
  def new
    reset_session
    @signup = Signup.new
  end

  def create
    reset_session
    @signup = Signup.new signup_params
    @signup.have = Barterable.find_or_create_by(description: params[:signup][:have][:description])
    @signup.need = Barterable.find_or_create_by(description: params[:signup][:need][:description])

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
    params.require(:signup).permit(:email, :name, have_attributes: [:description], need_attributes: [:description])
  end
end
