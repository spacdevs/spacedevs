require 'rails_helper'

feature 'Authentication' do
  let(:user) { create(:user, :student, :with_profile) }

  scenario 'when try logins to in successfully' do
    visit new_session_path
    fill_in 'Matricula', with: user.registration_code
    fill_in 'Senha', with: user.password
    click_button 'Acessar'

    expect(status_code).to eq(200)
    expect(current_path).to eq(root_path)
  end

  context 'when the user is already authenticated' do
    before do
      login_as(user)
    end

    scenario 'he can log out' do
      click_on 'Sair'

      expect(status_code).to eq 200
      expect(page).to have_field 'Matricula'
    end

    scenario 'cannot view session page' do
      visit new_session_path

      expect(current_path).to eq root_path
    end
  end
end
