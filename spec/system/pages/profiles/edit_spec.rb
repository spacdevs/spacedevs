require 'rails_helper'

feature ProfilesController do
  let(:user) { create(:user, :with_profile) }

  before do
    user.create_user_school_enrollments!(school: user.school, degree: :first_year)
    allow(PasswordsMailer).to receive(:reset).with(user).and_return(double(deliver_now: true))
  end

  context 'logged user' do
    before do
      login_as(user)
    end

    scenario 'update email' do
      click_on 'Meu perfil', exact: true
      click_on 'Editar meu e-mail', exact: true
      fill_in 'E-mail', with: 'angelica@example.com'
      click_on 'Salvar'

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('angelica@example.com')
      expect(page).to have_content('Registro atualizado com sucesso')
      expect(user.reload.email_address).to eq('angelica@example.com')
    end

    scenario 'update with invalid email' do
      visit edit_profile_path
      fill_in 'E-mail', with: 'angelica@example'
      click_on 'Salvar'

      expect(current_path).not_to eq(edit_profile_path)
      expect(page).to have_content('E-mail não é válido')
    end

    scenario 'user reset password' do
      visit root_path
      click_on 'Meu perfil'
      click_on 'Resetar minha senha', exact: true

      expect(PasswordsMailer).to have_received(:reset).with(user).exactly(1).times
      expect(current_path).to eq new_session_path
      expect(page).to have_content('Encaminhamos um e-mail para redefinição de sua senha.')
    end
  end
end
