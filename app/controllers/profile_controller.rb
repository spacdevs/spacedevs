# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :set_profile, only: %i[show]

  def show;end

  private

  def set_profile
    @profile = Profile.find_by(slug: params[:slug])
  end
end
