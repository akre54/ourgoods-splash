class SignupMailer < ActionMailer::Base
  default from: "Jen Abrams <jen@ourgoods.org>"

  def welcome_email(signup)
    @signup = signup
    mail(to: @signup.email, subject: "Thanks for signing up to the OurGoods event on #{signup_date}!")
  end

  def new_registration(signup)
    @signup = signup
    mail(to: "jen@ourgoods.org", from: "notifications@ourgoods.org", subject: "New Signup for #{signup_date} event")
  end

  def signup_date
    I18n.localize @signup.event.event_begin_time, format: :event_date
  end
end
