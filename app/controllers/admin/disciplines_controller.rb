# frozen_string_literal: true

module Admin
  class DisciplinesController < AdminController
    def index
      @disciplines = Discipline.includes(teams: %i[users]).limit(15)
    end
  end
end
