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
    expect(page).to have_content('E-mail atualizado com sucesso')
    expect(user.reload.email_address).to eq('angelica@example.com')
  end

  scenario 'update with invalid email' do
    user = create(:user, :with_profile)

    login_as(user)
    visit edit_profile_path
    fill_in 'E-mail', with: 'angelica@example'
    click_on 'Salvar'

    expect(current_path).not_to eq(edit_profile_path)
    expect(page).to have_content('E-mail não é válido')
  end
end
