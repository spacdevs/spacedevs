require 'rails_helper'

feature 'Authentication' do
  scenario 'log in with valid credentials' do
    user = create(:user, :student)

    visit new_session_path
    fill_in 'Matricula', with: user.registration_code
    fill_in 'Senha', with: user.password
    click_button 'Entrar'

    expect(status_code).to eq(200)
    expect(current_path).to eq(root_path)
  end

  scenario 'log off authenticated user' do
    user = create(:user, :student)

    login_as(user)
    click_on 'Sair'

    expect(status_code).to eq 200
    expect(page).to have_field 'Matricula'
  end

  scenario 'already authenticated user cannot view session page' do
    user = create(:user, :student)

    login_as(user)
    visit new_session_path

    expect(current_path).to eq root_path
  end
end
