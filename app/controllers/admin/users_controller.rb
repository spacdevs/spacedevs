# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    before_action :set_user, only: %i[index search]

    def index
    end

    def search
      @users = @users.where(
        "CONCAT(LOWER(profiles.first_name), ' ', LOWER(profiles.last_name)) LIKE ?", "%#{q.downcase}%"
      )

      render :index
    end

    private

    def q
      @q ||= params.permit(:q).fetch(:q)
    end

    def set_user
      @users = User.includes(:profile).student.order('profiles.first_name, profiles.last_name ASC')
    end
  end
end
