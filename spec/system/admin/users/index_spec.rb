require 'rails_helper'

feature Admin::UsersController do
  let(:admin)    { create(:user, :with_profile, :admin) }
  let(:student)  { create(:user, :with_profile, :student) }
  let(:student2) { create(:user, :with_profile, :student) }

  before do
    student.create_user_school_enrollments!(school: student.school, degree: :first_year)
    student2.create_user_school_enrollments!(school: student2.school, degree: :first_year)
  end

  scenario 'check if Admin word exists' do
    login_as(admin)

    expect(page).to have_content('Admin')
  end

  scenario 'admin sees students' do
    login_as(admin)
    click_on 'Alunos'

    expect(current_path).to have_content(admin_users_path)
    expect(page).to have_content(student.profile.fullname)
    expect(page).to have_content(student.email)
    expect(page).to have_content(I18n.l(student.created_at, format: :short))
    expect(page).to have_content('1º ano do ensino médio')
    expect(page).to have_content(student.profile.whatsapp)
  end

  scenario 'admin sees only 10 students' do
    create_list(:user, 15, :with_profile, :student).each do |student|
      create(:user_school_enrollments, school: student.school, user: student)
    end

    login_as(admin)
    click_on 'Alunos'

    expect(page).to have_css('.user', count: 10)
  end

  scenario 'admin sees ordered users' do
    student.profile.update!(fullname: 'Ana Claudia Melo')
    student2.profile.update!(fullname: 'Marcelo Aguiar')

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
    student.profile.update!(fullname: 'Ana Claudia Melo')
    student2.profile.update!(fullname: 'Simão Silva')

    login_as(admin)
    click_on 'Alunos'
    find('input[placeholder="Buscar"]').set('Ana Claudia Melo')
    click_on 'manda vê'

    expect(page).to have_content('Ana Claudia')
    expect(page).not_to have_content('Simão Silva')
  end

  scenario 'admin finds user by part of name' do
    student.profile.update!(fullname: 'Ana Claudia Melo')
    student2.profile.update!(fullname: 'Simão Silva')

    login_as(admin)
    click_on 'Alunos'
    find('input[placeholder="Buscar"]').set('Claudia')
    click_on 'manda vê'

    expect(page).to have_content('Ana Claudia Melo')
    expect(page).not_to have_content('Simão Silva')
  end

  scenario 'user cannot found' do
    student.profile.update!(fullname: 'Ana Claudia Melo')

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
    login_as(student)

    expect(page).not_to have_content('ADMIN')
    expect(page).not_to have_content('Alunos')
  end

  scenario 'user tries to access a direct route and gets redirected to the home page' do
    login_as(student)
    visit admin_users_path

    expect(current_path).to eq(root_path)
    expect(page).not_to have_content('ADMIN')
    expect(page).not_to have_content('Alunos')
  end

  scenario 'block user' do
    student.profile.update!(fullname: 'Camila Rosa')
    student2.update!(disabled_at: Time.zone.now)

    login_as(admin)
    visit admin_users_path
    click_on 'Bloquear'

    expect(current_path).to eq(admin_users_path)
    expect(page).to have_content('Usuário bloqueado')
    expect(page).to have_content('Camila Rosa foi bloqueado com sucesso')
    expect(page).not_to have_content('Bloquear')
    expect(student.reload.disabled_at).to be_present
  end

  scenario 'user already blocked' do
    student.update!(disabled_at: Time.zone.now)
    student2.update!(disabled_at: Time.zone.now)

    login_as(admin)
    visit admin_users_path

    expect(page).not_to have_content('Bloquear')
    expect(page).to have_content('Usuário bloqueado')
  end
end
