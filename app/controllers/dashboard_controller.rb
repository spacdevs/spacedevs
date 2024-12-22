class DashboardController < ApplicationController
  before_action :authenticated?, only: :index

  def index
  end
end
