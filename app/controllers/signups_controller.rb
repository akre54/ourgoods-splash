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
      render 'signups/thanks', status: :created, location: @signup
    else
      flash[:notice] = "There was an error creating your entry"
      render 'signups/new', status: :unprocessable_entity
    end
  end
end
