# frozen_string_literal: true

class ContentsController < ApplicationController
  def show
    @content = Content.find_by!(slug: content_params[:content_slug])
  end
end
