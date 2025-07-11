# frozen_string_literal: true

class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[edit update]

  def new; end

  def edit; end

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_now
    end

    terminate_session
    redirect_to new_session_path, notice: 'Encaminhamos um e-mail para redefinição de sua senha.'
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_path, notice: 'Password has been reset.'
    else
      redirect_to edit_password_path(params[:token]), alert: 'Senha inválida'
    end
  end

  private

  def set_user_by_token
    @user = User.find_by_password_reset_token!(params[:token])
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to new_password_path, alert: 'Link para reseta senha inválido ou expirado.'
  end
end
