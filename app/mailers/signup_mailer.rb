class SignupMailer < ActionMailer::Base
  default from: "Jen Abrams <jen@ourgoods.org>"

  def welcome_email(signup)
    @signup = signup
    mail(to: @signup.email, subject: 'Thanks for signing up to OurGoods')
  end

  def new_registration(signup)
    @signup = signup
    mail(to: "jen@ourgoods.org", from: "notifications@ourgoods.org", subject: "New Signup for event")
  end
end
