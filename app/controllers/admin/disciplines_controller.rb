# frozen_string_literal: true

module Admin
  class DisciplinesController < AdminController
    before_action :set_discipline, only: %i[show edit update]

    def index
      @disciplines = Discipline.limit(15)
    end

    def show
      @contents = Content.includes(:discipline)
                         .where(discipline: { id: @discipline.id })
    end

    def new
      @discipline = Discipline.new
    end

    def edit; end

    def create
      @discipline = Discipline.new(discipline_params.except(:team_name))

      render :new unless @discipline.save

      redirect_to admin_disciplines_path, notice: I18n.t('messages.create.success', title: 'Disciplína') if @discipline.save
    end

    def update
      @discipline.update(discipline_params.except(:team_ids))

      render :edit unless @discipline.persisted?

      redirect_to edit_admin_discipline_path(@discipline.id), notice: I18n.t('messages.update.success', title: 'Disciplína')
    end

    # rubocop:disable Rails/SkipsModelValidations
    def update_position
      params[:order].each_with_index do |content_id, content_index|
        Content.where(id: content_id).update_all(position: content_index + 1)
      end
    end
    # rubocop:enable Rails/SkipsModelValidations

    private

    def set_discipline
      @discipline = Discipline.find(params[:id])
    end

    def discipline_params
      params.expect(discipline: [:title, :abstract, :position, :body, :available_on, { team_ids: [] }])
            .transform_values! { |param| param.is_a?(Array) ? param.compact_blank : param }
            .compact_blank
    end
  end
end
