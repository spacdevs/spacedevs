# frozen_string_literal: true

module Admin
  class TeamsController < AdminController
    before_action :set_team, only: %i[new]
    def index
      @teams = Team.all
    end

    def new; end

    private

    def set_team
      @team = Team.new
    end
  end
end
