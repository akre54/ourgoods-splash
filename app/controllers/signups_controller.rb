class SignupsController < ApplicationController
  def new
    @signup = Signup.new
  end

  def create
    @signup = Signup.new
    @signup.email = params[:email]
    @signup.name = params[:name]
    @signup.have = Barterable.find_or_create_by_description(params[:have])
    @signup.need = Barterable.find_or_create_by_description(params[:need])

    if @signup.save
      session[:signup_id] = @signup.id
      redirect_to success_path
    else
      flash[:notice] = "There was an error creating your entry"
      render 'signups/new', status: :unprocessable_entity
    end
  end

  def success
    @signup = Signup.find session[:signup_id]
    session[:signup_id] = nil
  end
end
