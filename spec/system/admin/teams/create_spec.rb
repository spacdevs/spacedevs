require 'rails_helper'

feature Admin::TeamsController do
  let(:admin_user) { create(:user, :with_profile, :admin) }

  before do
    login_as(admin_user)
    click_on 'Turmas'
    click_on 'Adicionar'
  end

  scenario 'creates a team' do
    fill_in 'Nome', with: 'Colégio Estadual Roberto Santos - Turma 01'
    find(:css, "#team_active[value='1']").set(true)
    click_on 'Criar Turma'

    expect(current_path).to eq admin_teams_path
    expect(page).to have_content('Turma criado(a) com sucesso.')
    expect(Team.count).to eq(1)
  end

  scenario 'without name attributes' do
    find(:css, "#team_active[value='1']").set(true)
    click_on 'Criar Turma'

    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
