class DisciplinesController < ApplicationController
  def show
    @discipline = Discipline.find_by!(slug: discipline_params[:slug])
  end

  def discipline_params
    params.permit(:slug)
  end
end
