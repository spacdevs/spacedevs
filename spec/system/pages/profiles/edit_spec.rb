require 'rails_helper'

feature 'Edit profile' do
  scenario 'update email' do
    user = create(:user, :with_profile)

    login_as(user)
    click_on 'Meu perfil'
    click_on 'Editar'
    fill_in 'E-mail', with: 'angelica@example.com'
    click_on 'Salvar'

    expect(current_path).to eq(profile_path)
    expect(page).to have_content('angelica@example.com')
    expect(user.reload.email_address).to eq('angelica@example.com')
  end
end
