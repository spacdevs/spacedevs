require 'rails_helper'

feature Admin::UsersController do
  let(:admin) { create(:user, :admin) }
  let!(:student) { create(:user, :with_profile, :student) }

  before do
    login_as(admin)
  end

  scenario 'view registered users' do
    click_on 'Alunos'

    expect(current_path).to have_content(admin_users_path)
    expect(page).to have_content(student.profile.fullname)
    expect(page).to have_content(student.email)
    expect(page).to have_content(I18n.l(student.created_at, format: :short))
  end
end
