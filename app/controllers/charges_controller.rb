class ChargesController < ApplicationController
  def new
  end

  def create

    customer = Stripe::Customer.create(
      email: @signup.email,
      card:  params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,
      amount:       (@event.price * 100).floor,
      description:  'OurGoods Idea Lab ticket',
      currency:     'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
