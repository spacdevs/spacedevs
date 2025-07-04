require 'rails_helper'

feature Admin::DisciplinesController do
  let(:admin) { create(:user, :with_profile, :admin) }

  context 'when the call successfully' do
    let!(:content) { create(:content, :with_discipline, :text) }

    before do
      login_as(admin)
      click_on 'Disciplinas'

      find("a[title='#{content.discipline.title}']").click
    end

    scenario 'must have content title' do
      within 'div > div:nth-child(1) > article > header > h3' do
        expect(page).to have_content(content.title)
      end
    end

    scenario 'must have discipline title' do
      within 'div > div:nth-child(1) > article > div > p' do
        expect(page).to have_content(content.discipline.title)
      end
    end

    scenario 'must have content position' do
      within 'div > div:nth-child(1) > article > header > h3 > span' do
        expect(page).to have_content(content.position)
      end
    end
  end

  context 'when not exist contents' do
    before do
      discipline = create(:discipline)
      login_as(admin)
      click_on 'Disciplinas'
      find("a[title='#{discipline.title}']").click
    end

    scenario 'without discipline to displaying' do
      expect(page).to have_content('Não há conteúdos para serem exibidos.')
    end
  end
end
