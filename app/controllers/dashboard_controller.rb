class DashboardController < ApplicationController
  before_action :authenticated?, only: :index

  def index
    @disciplines = Discipline.all.order(:position)

    notification_user_message
  end

  private

  def notification_user_message
    @notifications = []

    @notifications << "Termine de configurar seu perfil para ter acesso ao conteúdo" if current_user.profile.blank?
    @notifications << "Estamos trabalhando no conteúdo para te ofertar, enquanto isso descanse 😁" if @disciplines.blank?
  end
end
