# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :current_profile
  before_action :can_access?

  def show;end

  private

  def can_access?
    redirect_to root_path if @profile.blank?
  end
end
