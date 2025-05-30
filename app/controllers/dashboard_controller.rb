# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticated?, only: :index

  def index
    @disciplines = Discipline.includes(%i[rich_text_abstract])
                             .joins('JOIN contents ON contents.discipline_id = disciplines.id')
                             .joins('JOIN discipline_subscribers ds ON ds.discipline_id = disciplines.id')
                             .order(:position)
                             .group('contents.id', 'disciplines.id')
                             .select('disciplines.id', 'disciplines.title', 'disciplines.slug',
                               'COUNT(contents.id) contents_count', 'disciplines.position')
                             .distinct
  end
end
