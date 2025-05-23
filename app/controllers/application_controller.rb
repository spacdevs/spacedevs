class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user, :current_profile

  rescue_from ActiveRecord::RecordNotFound, with: :page_not_found
  rescue_from ActionController::RoutingError, with: :page_not_found

  private

  def current_user
    current_session&.user
  end

  def current_session
    @current_session ||= Session.find_by(id: cookies.signed[:session_id])
  end

  def page_not_found(exception = nil)
    redirect_to root_url, alert: exception&.message || 'Página não encontrada'
  end
end
