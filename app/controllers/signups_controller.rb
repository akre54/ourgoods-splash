class SignupsController < ApplicationController
  def new
    @signup = Signup.new
    @signup.event = Event.active.first
    @signup.skill = Barterable.new
    @signup.item = Barterable.new
  end

  def create
    valid_params = signup_params
    @signup = Signup.new valid_params

    unless valid_params[:item_attributes][:description].blank?
      @signup.item = Barterable.find_or_create_by valid_params[:item_attributes]
    else
      @signup.item = nil
    end
    unless valid_params[:skill_attributes][:description].blank?
      @signup.skill = Barterable.find_or_create_by valid_params[:skill_attributes]
    else
      @signup.skill = nil
    end

    if @signup.save
      session[:signup_id] = @signup.id
      SignupMailer.welcome_email(@signup).deliver
      SignupMailer.new_registration(@signup).deliver
      redirect_to success_path
    else
      @signup.skill = Barterable.new valid_params[:item_attributes]
      @signup.item = Barterable.new valid_params[:skill_attributes]
      flash.now[:error] = @signup.errors.full_messages
      render 'signups/new', status: :unprocessable_entity
    end
  end

  def success
    redirect_to new_signup_path unless session[:signup_id]

    @signup = Signup.find session[:signup_id]
    session[:signup_id] = nil
  end

  def spreadsheet
    @signups = Signup.order 'id'
    respond_to do |format|
      format.html
      format.csv { render text: @signups.to_csv }
      format.xls
    end
  end

private
  def signup_params
    params.require(:signup).permit(:email, :name, :community, :event_id, item_attributes: :description, skill_attributes: :description)
  end
end
