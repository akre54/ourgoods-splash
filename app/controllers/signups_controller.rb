class SignupsController < ApplicationController
  def new
    @signup = Signup.new
  end

  def create
    permitted_params = signup_params
    [:have, :need].each do |sym|
      permitted_params[sym] = Barterable.find_or_create_by description: permitted_params[sym][:description]
    end
    @signup = Signup.new permitted_params

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
    params.require(:signup).permit(:email, :name, have: :description, need: :description)
  end
end
