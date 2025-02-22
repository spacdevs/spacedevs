# frozen_string_literal: true

module Admin
  class DisciplinesController < AdminController
    def index
    @disciplines = Discipline.limit(15)
    end
  end
end
