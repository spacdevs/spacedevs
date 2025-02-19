# frozen_string_literal: true

class AdminController < ApplicationController
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :admin_user?

  private

  def admin_user?
    redirect_to root_path unless current_user.admin?
  end
end
