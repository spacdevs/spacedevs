# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticated?, only: :index

  def index
    @disciplines = Discipline.includes(%i[rich_text_abstract]).order(:position)
                             .joins('JOIN discipline_subscribers ds ON ds.discipline_id = disciplines.id')
  end
end
