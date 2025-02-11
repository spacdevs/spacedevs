# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :current_profile
  before_action :can_access?

  def show;end

  def edit;end

  def update
    return redirect_to profile_path, notice: 'E-mail atualizado com sucesso' if @profile.update(profile_params)

    render :edit
  end

  private

  def can_access?
    redirect_to root_path if @profile.blank?
  end

  def profile_params
    params.require(:profile).permit(user_attributes: %i[email]).transform_values(&:compact_blank!)
  end
end
