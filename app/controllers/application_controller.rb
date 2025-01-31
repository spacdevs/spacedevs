class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user, :current_profile

  private

  def current_user
    current_session&.user
  end

  def current_session
    @current_session ||= Session.find_by(id: cookies.signed[:session_id])
  end

  def current_profile
    @profile ||= current_user&.profile
  end
end
