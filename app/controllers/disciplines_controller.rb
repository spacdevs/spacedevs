# frozen_string_literal: true

class DisciplinesController < ApplicationController
  def show
    @discipline = Discipline.find_by!(slug: discipline_params[:slug])
    @contents = @discipline.contents.order(:position)
  end

  def discipline_params
    params.permit(:slug)
  end
end
