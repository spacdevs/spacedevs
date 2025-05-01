# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  def send_email(user)
    @user = user
    @password_temp = SecureRandom.hex(5).upcase

    return unless @user.profile

    mail subject: "Boas vindas #{user.profile.first_name} 🧸", to: user.email_address
  end
end
