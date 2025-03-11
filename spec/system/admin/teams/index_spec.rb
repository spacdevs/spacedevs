require 'rails_helper'

feature Admin::TeamsController do
  let(:admin_user) { create(:user, :with_profile, :admin) }
  let!(:team)      { create(:team, active: true, updated_at: updated_at) }
  let(:updated_at) { Time.zone.local(2025, 1, 1, 12, 0, 0) }

  before do
    login_as(admin_user)
    click_on 'Turmas'
  end

  scenario 'when admin views teams' do
    expect(page).to have_content(team.name)
    expect(I18n.l(team.updated_at, format: :short)).to eq '01 de janeiro, 12:00'
    expect(team.active).to eq(true)
    expect(page).to have_content('Lançado')
  end

  scenario 'when team#active is falsey' do
    team.update(active: false)

    visit admin_teams_path

    expect(team.active).to eq(false)
    expect(page).to have_content('Indisponível')
  end

  scenario 'when admin cannot views teams' do
    Team.destroy_all

    visit admin_teams_path

    expect(page).to have_content('Não há registros de turmas')
  end
end
