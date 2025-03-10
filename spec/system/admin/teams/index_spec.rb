require 'rails_helper'

feature Admin::TeamsController do
  let(:admin_user) { create(:user, :with_profile, :admin) }

  context 'when found teams' do
    let!(:teams) { create_list(:team, 3) }

    scenario 'admin views teams' do
      login_as(admin_user)
      click_on 'Turmas'

      teams.each do
        expect(page).to have_content(it.name)
      end
    end
  end

  context 'when teams cannot be found' do
    scenario 'admin cannot views teams' do
      login_as(admin_user)
      visit admin_teams_path

      expect(page).to have_content('Não há registros de turmas')
    end
  end
end
