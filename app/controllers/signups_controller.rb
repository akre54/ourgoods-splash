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

    setup_item_and_skill(valid_params)
    verify_stripe_token()

    if @signup.errors.empty? && @signup.save
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
    params.require(:signup).permit(
      :email, :name, :community, :event_id, :stripe_token,
      item_attributes: :description,
      skill_attributes: :description
    )
  end

  def setup_item_and_skill(valid_params)
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
  end

  def verify_stripe_token
    return if @signup.event.free?

    begin
      token = Stripe::Token.retrieve @signup.stripe_token

      if @signup.email != token.email
        @signup.errors.add :email, "The email associated with your charge must match your signup email"
        return
      end

      charge = Stripe::Charge.create(
        card:         @signup.stripe_token,
        amount:       (@signup.event.price * 100).floor,
        description:  'OurGoods Idea Lab ticket',
        currency:     'usd'
      )
    rescue Stripe::CardError => e
      # Since it's a decline, Stripe::CardError will be caught
      body = e.json_body
      err  = body[:error]

      puts "Status is: #{e.http_status}"
      puts "Type is: #{err[:type]}"
      puts "Code is: #{err[:code]}"
      # param is '' in this case
      puts "Param is: #{err[:param]}"
      puts "Message is: #{err[:message]}"

      @signup.errors.add :name, err[:message]

      return

    rescue Stripe::InvalidRequestError => e
      # Invalid parameters were supplied to Stripe's API
    rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
    rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
    rescue => e
      # Something else happened, completely unrelated to Stripe
    end

    @signup.paid = charge.paid
  end
end
