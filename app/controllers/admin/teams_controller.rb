# frozen_string_literal: true

module Admin
  class TeamsController < AdminController
    before_action :set_team, only: %i[edit update]
    def index
      @teams = Team.all
    end

    def new
      @team = Team.new
    end

    def edit; end

    def create
      @team = Team.new(team_params)

      return render(:new) unless @team.save

      redirect_to admin_teams_path, notice: I18n.t('messages.create.success', title: 'Turma')
    end

    def update
      return render :edit unless @team.update(team_params)

      redirect_to admin_teams_path, notice: I18n.t('messages.update.success')
    end

    private

    def team_params
      params.expect(team: %i[name active])
    end

    def set_team
      @team = Team.find(params[:id])
    end
  end
end
