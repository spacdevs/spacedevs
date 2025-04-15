# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticated?, only: :index

  def index
    @disciplines = Discipline.includes([:rich_text_abstract]).order(:position)
  end
end
