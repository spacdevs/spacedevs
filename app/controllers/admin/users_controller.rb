# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    def index
      @users = User.includes(:profile).student.order('profiles.first_name, profiles.last_name ASC')
    end
  end
end
