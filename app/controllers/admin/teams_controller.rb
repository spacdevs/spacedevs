# frozen_string_literal: true

module Admin
  class TeamsController < AdminController
    def index
      @teams = Team.all
    end
  end
end
