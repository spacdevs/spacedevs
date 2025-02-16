require 'rails_helper'

feature Admin::UsersController do
  let(:admin) { create(:user, :with_profile, :admin) }
  let!(:student) { create(:user, :with_profile, :student) }

  scenario 'check if Administração word exists' do
    create_list(:user, 2, :with_profile, :student)
    login_as(admin)

    expect(page).to have_content('Administração')
  end

  scenario 'admin view registered users' do
    login_as(admin)
    click_on 'Alunos'

    expect(current_path).to have_content(admin_users_path)
    expect(page).to have_content(student.profile.fullname)
    expect(page).to have_content(student.email)
    expect(page).to have_content(I18n.l(student.created_at, format: :short))
  end

  scenario 'cannot view admin user' do
    login_as(admin)
    click_on 'Alunos'

    within '#users' do
      expect(page).not_to have_content(admin.profile.fullname)
    end
  end

  scenario 'student cannot view others registered students' do
    login_as(student)

    expect(page).not_to have_content('ADMIN')
    expect(page).not_to have_content('Alunos cadastrados')
  end

  scenario 'user tries to access a direct route and gets redirected to the home page' do
    login_as(student)
    visit admin_users_path

    expect(current_path).to eq(root_path)
    expect(page).not_to have_content('ADMIN')
    expect(page).not_to have_content('Alunos cadastrados')
  end
end
