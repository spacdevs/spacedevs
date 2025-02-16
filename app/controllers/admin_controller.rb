# frozen_string_literal: true

class AdminController < ApplicationController
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :is_admin?

  private

  def is_admin?
    current_user.admin?
  end
end
