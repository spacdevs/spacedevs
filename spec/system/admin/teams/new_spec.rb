require 'rails_helper'

feature Admin::TeamsController do
  let(:admin_user) { create(:user, :with_profile, :admin) }

  before do
    login_as(admin_user)
    click_on 'Turmas'
  end

  scenario 'creates a team' do
    click_on 'Adicionar'

    expect(page).to have_field('Nome')
    expect(page).to have_field('Ativo?')
  end
end
