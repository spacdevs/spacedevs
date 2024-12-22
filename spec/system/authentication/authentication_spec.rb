require 'rails_helper'

feature 'Authentication' do
  scenario 'Login with valid credentials' do
    user = create(:user, :student)

    visit new_session_path
    fill_in 'Matricula', with: user.registration_code
    fill_in 'Senha', with: user.password
    click_button 'Entrar'

    expect(status_code).to eq 200
    expect(page).to        have_content 'Olá Spacer, seja bem-vindo!'
  end
end
