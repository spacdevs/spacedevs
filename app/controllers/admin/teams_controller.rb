# frozen_string_literal: true

module Admin
  class TeamsController < AdminController
    before_action :set_team, only: %i[new]
    def index
      @teams = Team.all
    end

    def new; end

    def create
      @team = Team.new(team_params)
      @team.save ? redirect_to(admin_teams_path, notice: I18n.t('messages.success')) : render(:new)
    end

    private

    def team_params
      params.expect(team: %i[name active])
    end

    def set_team
      @team = Team.new
    end
  end
end
