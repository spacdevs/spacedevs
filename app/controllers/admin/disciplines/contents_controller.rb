# frozen_string_literal: true

module Admin
  module Disciplines
    class ContentsController < AdminController
      def index
      end

      def edit
        @content = Content.find_by(id: params[:id], discipline_id: params[:discipline_id])
      end
    end
  end
end
