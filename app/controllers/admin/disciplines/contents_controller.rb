# frozen_string_literal: true

module Admin
  module Disciplines
    class ContentsController < AdminController
      before_action :find_content, only: %i[edit update]
      before_action :find_discipline, only: %i[new create update]
      before_action :initialize_content, only: %i[new create]

      def new; end

      def edit; end

      def create
        return render :new unless @content.save

        redirect_to admin_discipline_path(@discipline), notice: I18n.t('messages.update.success')
      end

      def update
        return render :edit unless @content.update(content_params)

        redirect_to edit_admin_discipline_content_path(
          discipline_id: @discipline.id, content_id: @content.id
        ), notice: I18n.t('messages.update.success')
      end

      private

      def content_params
        params.expect(content: %i[title body kind position video_id]).tap do |param|
          param[:kind] = param[:kind]&.to_sym
        end
      end

      def find_content
        @content = Content.find_by!(id: params[:id], discipline_id: params[:discipline_id])
      end

      def find_discipline
        @discipline = Discipline.find(params[:discipline_id])
      end

      def initialize_content
        @content = action_name == 'create' ? @discipline.contents.build(content_params) : Content.new
      end
    end
  end
end
