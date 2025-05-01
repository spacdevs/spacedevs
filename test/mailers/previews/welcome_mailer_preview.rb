class WelcomeMailerPreview < ActionMailer::Preview
  def send_email
    WelcomeMailer.send_email(User.take)
  end
end
