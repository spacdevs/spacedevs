require 'rails_helper'

feature Admin::UsersController do
  let(:admin) { create(:user, :with_profile, :admin) }

  scenario 'check if Administração word exists' do
    login_as(admin)

    expect(page).to have_content('Administração')
  end

  scenario 'admin view registered users' do
    student = create(:user, :with_profile, :student)

    login_as(admin)
    click_on 'Alunos'

    expect(current_path).to have_content(admin_users_path)
    expect(page).to have_content(student.profile.fullname)
    expect(page).to have_content(student.email)
    expect(page).to have_content(I18n.l(student.created_at, format: :short))
  end

  scenario 'admin search user' do
    create(:user, :with_profile, :student, first_name: 'Ana Claudia', last_name: 'Melo')
    create(:user, :with_profile, :student, first_name: 'Simão', last_name: 'Silva')

    login_as(admin)
    click_on 'Alunos'
    fill_in 'Buscar', with: 'Ana Claudia Melo'
    click_on 'manda vê'

    expect(page).to have_content('Ana Claudia')
    expect(page).not_to have_content('Simão Silva')
  end

  scenario 'admin view ordered users' do
    user1 = create(:user, :with_profile, :student)
    user2 = create(:user, :with_profile, :student)
    user1.profile.update!(first_name: 'Marcelo', last_name: 'Aguiar')
    user2.profile.update!(first_name: 'Ana Claudia', last_name: 'Melo')

    login_as(admin)
    click_on 'Alunos'

    within '#users > tbody > tr:nth-child(1) > th.uk-width-small' do
      expect(page).to have_content('Ana Claudia')
    end
    within '#users > tbody > tr:nth-child(2) > th.uk-width-small' do
      expect(page).to have_content('Marcelo Aguiar')
    end
  end

  scenario 'cannot view admin user' do
    login_as(admin)
    click_on 'Alunos'

    within '#users' do
      expect(page).not_to have_content(admin.profile.fullname)
    end
  end

  scenario 'student cannot view others registered students' do
    student = create(:user, :with_profile, :student)

    login_as(student)

    expect(page).not_to have_content('ADMIN')
    expect(page).not_to have_content('Alunos cadastrados')
  end

  scenario 'user tries to access a direct route and gets redirected to the home page' do
    student = create(:user, :with_profile, :student)

    login_as(student)
    visit admin_users_path

    expect(current_path).to eq(root_path)
    expect(page).not_to have_content('ADMIN')
    expect(page).not_to have_content('Alunos cadastrados')
  end
end
