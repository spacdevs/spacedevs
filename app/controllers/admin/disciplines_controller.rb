# frozen_string_literal: true

module Admin
  class DisciplinesController < AdminController
    before_action :set_discipline, :set_teams, only: %i[show edit update]
    before_action :set_teams, only: %i[new create edit]

    def index
      @disciplines = Discipline.includes(teams: %i[users]).limit(15)
    end

    def show
      @contents = Content.joins('JOIN disciplines discipline ON contents.discipline_id = discipline.id')
    end

    def new
      @discipline = Discipline.new
    end

    def edit; end

    def create
      @discipline = Discipline.new(discipline_params.except(:team_name)
                                                    .merge(teams: teams))

      render :new unless @discipline.save

      redirect_to admin_disciplines_path, notice: I18n.t('messages.create.success', title: 'Disciplína') if @discipline.save
    end

    def update
      @discipline.update(discipline_params.except(:team_ids).merge(teams: teams))

      render :edit unless @discipline.persisted?

      redirect_to admin_disciplines_path, notice: I18n.t('messages.update.success', title: 'Disciplína')
    end

    def set_teams
      @teams = Team.all
    end

    private

    def set_discipline
      @discipline = Discipline.includes(:teams).find(params[:id])
    end

    # rubocop:disable Rails/StrongParametersExpect
    def discipline_params
      params.require(:discipline).permit(:title, :abstract, :position, :body, :available_on, { team_ids: [] })
    end
    # rubocop:enable Rails/StrongParametersExpect

    def teams
      Team.where(id: discipline_params[:team_ids])
    end
  end
end
