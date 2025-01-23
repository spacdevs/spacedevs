# frozen_string_literal: true

class ContentsController < ApplicationController
  def show
    @content = Content.includes(:discipline).find_by!(slug: params[:content_slug])
  end
end
