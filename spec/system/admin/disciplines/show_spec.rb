require 'rails_helper'

feature Admin::DisciplinesController do
  let(:admin) { create(:user, :with_profile, :admin) }

  context 'when the call successfully' do
    let!(:content) { create(:content, :with_discipline, :text) }

    before do
      login_as(admin)
      click_on 'Disciplinas'
      find('a[title="view the contents"]').click
    end

    scenario 'admin view disciplines' do
      expect(page).to have_content(content.discipline.title)
      expect(page).to have_content(content.title)
      expect(page).to have_content('Texto')
    end
  end

  context 'when not exist contents' do
    before do
      create(:discipline)
      login_as(admin)
      click_on 'Disciplinas'
      find('a[title="view the contents"]').click
    end

    scenario 'without discipline to displaying' do
      expect(page).to have_content('Não há conteúdos para serem exibidos.')
    end
  end
end
