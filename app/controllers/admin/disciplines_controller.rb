# frozen_string_literal: true

module Admin
  class DisciplinesController < AdminController
    before_action :set_disciplines, only: %i[index]
    def index; end

    def new
      @discipline = Discipline.new
      @team_names = Team.pluck(:name)
    end

    def edit; end

    def create
      @discipline = Discipline.new(discipline_params.except(:team_name)
                                                    .merge(teams: [team]))

      return redirect_to admin_disciplines_path, notice: I18n.t('messages.create.success', title: 'Disciplína') if @discipline.save

      render :new
    end

    private

    def set_disciplines
      @disciplines = Discipline.includes(teams: %i[users]).limit(15)
    end

    def discipline_params
      params.expect(discipline: %i[title abstract position body available_on team_name])
    end

    def team
      Team.find_by(name: discipline_params[:team_name])
    end
  end
end
