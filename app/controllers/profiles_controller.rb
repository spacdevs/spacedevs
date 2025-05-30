# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :current_profile
  before_action :can_access?

  def show; end

  def edit; end

  def update
    if @profile.update(profile_params)
      return redirect_to edit_profile_path, notice: I18n.t(
        'messages.update.success', alias_name: 'E-mail'
      )
    end

    render :edit
  end

  private

  def current_profile
    @profile = current_user&.profile
  end

  def can_access?
    redirect_to root_path if @profile.blank?
  end

  def profile_params
    params.expect(profile: [user_attributes: %i[email]]).transform_values(&:compact_blank!)
  end
end
