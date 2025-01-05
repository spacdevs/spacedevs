class DashboardController < ApplicationController
  before_action :authenticated?, only: :index

  def index
    @disciplines = Discipline.all.order(:position)

    notification_user_message
  end

  private

  def notification_user_message
    @messages = []

    @messages << "Termine de configurar seu perfil para ter acesso ao conteúdo" if current_user.profile.blank?
    @messages << "Estamos preparando conteúdo para você e em breve você será notificado." if @disciplines.blank?
  end
end
