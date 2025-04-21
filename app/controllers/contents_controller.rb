# frozen_string_literal: true

class ContentsController < ApplicationController
  before_action :find_content, :sidebar_contents, only: %i[show]

  def show; end

  private

  def find_content
    @content = Content.includes(:discipline).find_by!(slug: params[:content_slug])
  end

  def sidebar_contents
    @sidebar_contents = @content.discipline.contents.order(:position)
  end
end
