require 'rails_helper'

feature Admin::UsersController do
  let(:admin) { create(:user, :with_profile, :admin) }

  scenario 'check if Administração word exists' do
    login_as(admin)

    expect(page).to have_content('Administração')
  end

  scenario 'admin sees students' do
    school = create(:school, name: 'Colégio Estadual Governador Roberto Santos')
    student = create(:user, :with_profile, :student, school:)
    student.profile.update!(degree: :first_year)

    login_as(admin)
    click_on 'Alunos'

    expect(current_path).to have_content(admin_users_path)
    expect(page).to have_content(student.profile.fullname)
    expect(page).to have_content(student.email)
    expect(page).to have_content(I18n.l(student.created_at, format: :short))
    expect(page).to have_content('Colégio Estadual Governador Roberto Santos')
    expect(page).to have_content('1º ano do ensino médio')
  end

  scenario 'admin sees only 10 students' do
    create_list(:user, 15, :with_profile, :student)

    login_as(admin)
    click_on 'Alunos'

    expect(page).to have_css('.user', count: 10)
  end

  scenario 'admin sees ordered users' do
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

  scenario 'admin search user' do
    create(:user, :with_profile, :student, first_name: 'Ana Claudia', last_name: 'Melo')
    create(:user, :with_profile, :student, first_name: 'Simão', last_name: 'Silva')

    login_as(admin)
    click_on 'Alunos'
    find('input[placeholder="Buscar"]').set('Ana Claudia Melo')
    click_on 'manda vê'

    expect(page).to have_content('Ana Claudia')
    expect(page).not_to have_content('Simão Silva')
  end

  scenario 'user cannot found' do
    create(:user, :with_profile, :student, first_name: 'Ana Claudia', last_name: 'Melo')

    login_as(admin)
    click_on 'Alunos'
    find('input[placeholder="Buscar"]').set('Simão Silva')
    click_on 'manda vê'

    expect(page).not_to have_content('Ana Claudia')
    expect(page).not_to have_content('Simão Silva')
  end

  scenario 'cannot sees admin user' do
    login_as(admin)
    click_on 'Alunos'

    within '#users' do
      expect(page).not_to have_content(admin.profile.fullname)
    end
  end

  scenario 'student cannot sees others registered students' do
    student = create(:user, :with_profile, :student)

    login_as(student)

    expect(page).not_to have_content('ADMIN')
    expect(page).not_to have_content('Alunos')
  end

  scenario 'user tries to access a direct route and gets redirected to the home page' do
    student = create(:user, :with_profile, :student)

    login_as(student)
    visit admin_users_path

    expect(current_path).to eq(root_path)
    expect(page).not_to have_content('ADMIN')
    expect(page).not_to have_content('Alunos')
  end

  scenario 'block user' do
    user = create(:user, :with_profile, :student, first_name: 'Camila', last_name: 'Rosa')

    login_as(admin)
    visit admin_users_path
    click_on 'Bloquear'

    expect(current_path).to eq(admin_users_path)
    expect(page).to have_content('Usuário bloqueado')
    expect(page).to have_content('Camila Rosa foi bloqueado com sucesso')
    expect(page).not_to have_content('Bloquear')
    expect(user.reload.disabled_at).to be_present
  end

  scenario 'user already blocked' do
    create(:user, :with_profile, :student, disabled_at: Time.zone.now)

    login_as(admin)
    visit admin_users_path

    expect(page).not_to have_content('Bloquear')
    expect(page).to have_content('Usuário bloqueado')
  end
end
