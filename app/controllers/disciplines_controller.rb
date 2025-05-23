# frozen_string_literal: true

class DisciplinesController < ApplicationController
  def show
    @discipline = Discipline.includes(resources: %i[file_attachment])
                            .joins('JOIN discipline_subscribers dp ON dp.discipline_id = disciplines.id')
                            .find_by!(slug: discipline_params[:slug])
    @contents = @discipline.contents
  end

  private

  def discipline_params
    params.permit(:slug)
  end
end
