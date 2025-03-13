# frozen_string_literal: true

module Admin
  module Disciplines
    class ContentsController < AdminController
      before_action :set_content, only: %i[edit update]

      def edit; end

      # rubocop:disable Style/IfUnlessModifier
      def update
        if @content.update(content_params.merge(kind_param))
          return redirect_to admin_discipline_path(params[:discipline_id]), notice: I18n.t('message.update.success')
        end

        render :edit
      end
      # rubocop:enable Style/IfUnlessModifier

      private

      def content_params
        params.expect(content: %i[title body kind])
      end

      def set_content
        @content = Content.find_by(id: params[:id], discipline_id: params[:discipline_id])
      end

      def kind_param
        {
          kind: content_params[:kind].to_sym
        }
      end
    end
  end
end
