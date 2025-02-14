require 'rails_helper'

feature SessionsController do
  let!(:user) { create(:user, :with_profile, email_address: 'angelica@example.com') }

  before do
    allow(PasswordsMailer).to receive(:reset).with(user).and_return(double(deliver_now: true))
  end

  scenario 'reset password' do
    visit root_path
    click_on 'Esqueci minha senha'
    fill_in 'E-mail', with: 'angelica@example.com'
    click_on 'Recuperar'

    expect(PasswordsMailer).to have_received(:reset).with(user).exactly(1).times
    expect(current_path).to eq(new_session_path)
    expect(page).to have_content('Enviamos um link para seu e-mail para redefinir sua senha')
  end

  scenario 'cannot send email to a non-existent user' do
    visit root_path
    click_on 'Esqueci minha senha'
    fill_in 'E-mail', with: 'not_exists@example.com'
    click_on 'Recuperar'

    expect(PasswordsMailer).to have_received(:reset).with(user).exactly(0).times
    expect(current_path).to eq(new_session_path)
    expect(page).to have_content('Enviamos um link para seu e-mail para redefinir sua senha')
  end
end
