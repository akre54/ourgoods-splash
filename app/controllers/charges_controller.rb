class ChargesController < ApplicationController
  def new
    redirect_to new_signup_path unless session[:signup_id]

    @signup = Signup.find session[:signup_id]
  end

  def create
    redirect_to new_signup_path unless session[:signup_id]

    @signup = Signup.find session[:signup_id]

    valid_params = charge_params
    @signup.stripe_token = valid_params[:stripe_token]

    verify_stripe_token()

    if @signup.errors.empty? && @signup.save
      redirect_to success_path
    else
      flash.now[:error] = @signup.errors.full_messages
      render 'signups/new', status: :unprocessable_entity
    end


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end


private
  def charge_params
    params.require(:signup).permit(
      :stripe_token
    )
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

      # If all goes well, mark as paid
      @signup.paid = true

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

      @signup.errors.add :stripe_token, "Sorry, something went wrong. Please contact adam.krebs@nyu.edu with a screenshot."

    rescue => e
      # Something else happened, completely unrelated to Stripe
    end

    @signup.paid = charge.paid
  end
end
