require 'rails_helper'

feature Admin::TeamsController do
  let(:admin_user) { create(:user, :with_profile, :admin) }

  before do
    create(:team)

    login_as(admin_user)
    click_on 'Turmas'
    find('a[title="edit"]').click
  end

  scenario 'edits a team' do
    expect(page).to have_field('Nome')
    expect(page).to have_field('Ativo?')
  end
end
