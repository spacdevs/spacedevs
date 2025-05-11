# frozen_string_literal: true

class DisciplinesController < ApplicationController
  def show
    @discipline = Discipline.includes(resources: :file_attachment).find_by!(slug: discipline_params[:slug])
    @contents = @discipline.contents
  end

  def discipline_params
    params.permit(:slug)
  end
end
