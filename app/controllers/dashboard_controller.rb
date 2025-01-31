# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticated?, only: :index

  def index
    @disciplines = Discipline.all.order(:position)

    notification_user_message
  end

  private

  def notification_user_message
    @notifications = []
    support_url = ENV.fetch("COMMUNITY_URL", "https://www.spacedevs.com.br")

    if current_user.profile.blank? && current_user.student?
      @notifications << "Termine de configurar seu perfil para ter acesso ao conteúdo"
    end

    if @disciplines.blank?
      @notifications << "Estamos trabalhando no conteúdo para te ofertar, " \
      "enquanto isso acesse a nossa <a href='#{support_url}'>comunidade</a>."
    end
  end
end
