require 'rails_helper'

feature Admin::TeamsController do
  let(:admin_user) { create(:user, :with_profile, :admin) }
  let!(:team) { create(:team, name: 'Colegio Estadual Computador & Cia', active: false) }

  before do
    login_as(admin_user)
    visit edit_admin_team_path(team)
  end

  scenario 'edits a team' do
    fill_in 'Nome', with: 'Spacedevs - Escola de desenvolvimento de software'
    find(:css, "#team_active[value='1']").set(true)
    click_on 'Atualizar Turma'

    expect(current_path).to eq admin_teams_path
    expect(page).to have_content('Spacedevs - Escola de desenvolvimento de software')
    expect(page).to have_content('Lançado')
  end
end
