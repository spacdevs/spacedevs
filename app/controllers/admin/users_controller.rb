# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    def index
      @users = User.includes(:profile).student
    end
  end
end
