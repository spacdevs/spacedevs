# frozen_string_literal: true

module Admin
  module Disciplines
    class ContentsController < AdminController
      before_action :set_content, only: %i[edit update]

      def edit; end

      def update
        if @content.update(content_params)
          redirect_to admin_discipline_path(params[:discipline_id]), notice: I18n.t('messages.update.success')
        else
          render :edit
        end
      end

      private

      def content_params
        params.expect(content: %i[title body kind]).tap do |param|
          param[:kind] = param[:kind]&.to_sym
        end
      end

      def set_content
        @content = Content.includes(:discipline).find_by!(id: params[:id], discipline_id: params[:discipline_id])
      end
    end
  end
end
