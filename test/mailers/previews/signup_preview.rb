class SignupPreview < ActionMailer::Preview
  def welcome
    SignupMailer.welcome_email Signup.first
  end

  def new_registration
    SignupMailer.new_registration Signup.first
  end
end