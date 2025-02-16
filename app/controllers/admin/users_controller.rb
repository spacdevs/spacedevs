# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    before_action :set_user, only: %i[index search]

    def index
    end

    def search
      @users = @users.where("CONCAT(profiles.first_name, ' ', profiles.last_name) ILIKE ?", "%#{params[:q]}%")

      render :index
    end

    private

    def set_user
      @users = User.includes(:profile).student.order('profiles.first_name, profiles.last_name ASC')
    end
  end
end
