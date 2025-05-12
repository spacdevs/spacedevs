# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  def send_email(user, generate_temp_password = nil)
    @user = user
    @password_temp = generate_temp_password

    return unless @user&.profile

    mail subject: "Boas vindas a Spacedevs, #{user.profile.first_name}!", to: user&.email_address
  end
end
