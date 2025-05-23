# frozen_string_literal: true

class ContentsController < ApplicationController
  before_action :find_content, :set_contents, only: %i[show]

  def show; end

  private

  def find_content
    @content = Content.includes(:discipline)
                      .joins('JOIN disciplines ON contents.discipline_id = disciplines.id')
                      .joins('JOIN discipline_subscribers ds ON ds.discipline_id = disciplines.id ')
                      .find_by!(slug: params[:content_slug])
  end

  def set_contents
    @contents = @content.discipline.contents
  end
end
