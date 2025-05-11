# frozen_string_literal: true

module Admin
  class ResourcesController < AdminController
    before_action :set_resources, only: %i[index]
    before_action :set_resource, only: %i[edit update destroy]
    before_action :set_disciplines, only: %i[new edit]
    before_action :set_discipline, only: %i[create update]

    def index; end

    def new
      @resource = Resource.new
    end

    def edit; end

    def create
      return redirect_to admin_resources_path, notice: I18n.t('messages.create.success', title: 'Recurso') if Resource.create(resource_params.merge(sourceable: @discipline))

      render :new
    end

    def update
      return redirect_to admin_resources_path, notice: I18n.t('messages.update.success') if @resource.update(resource_params.merge(sourceable: @discipline))

      render :edit
    end

    def destroy
      @resource.destroy
      redirect_to admin_resources_path, notice: I18n.t('messages.remove.success')
    end

    private

    def resource_params
      params.expect(resource: %i[name url file sourceable_id])
    end

    def set_resource
      @resource = Resource.find(params[:id])
    end

    def set_resources
      @resources = Resource.includes(:file_attachment, :sourceable).all
    end

    def set_disciplines
      @disciplines = Discipline.all
    end

    def set_discipline
      @discipline = Discipline.find(resource_params[:sourceable_id])
    end
  end
end
