# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    before_action :set_users, only: %i[index search block]

    def index; end

    def search
      @users = @users.where('LOWER(profiles.fullname) LIKE ?', "%#{q.downcase}%")

      render :index
    end

    def block
      @user = User.find(params[:id])

      return render :edit if @user.blank?

      @user.update(disabled_at: Time.zone.now)
      redirect_to admin_users_path, notice: I18n.t(
        'activerecord.success.user.block', name: @user.profile.fullname
      )
    end

    private

    def set_users
      @users = User.includes(:profile, :school)
                   .student
                   .order('profiles.fullname ASC')
                   .limit(10)
    end

    def q
      @q ||= params.permit(:q).fetch(:q)
    end
  end
end
