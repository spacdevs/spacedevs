require 'rails_helper'

feature Admin::DisciplinesController do
  let(:admin) { create(:user, :with_profile, :admin) }
  let!(:discipline) { create(:discipline) }

  scenario 'admin sees disciplines already registered' do
    content = create(:content, :text, discipline: discipline)

    login_as(admin)
    click_on 'Disciplinas'
    click_on discipline.title

    expect(page).to have_content(content.discipline.title)
    expect(page).to have_content(content.title)
    expect(page).to have_content('Texto')
  end

  scenario 'admin sees disciplines already registered' do
    login_as(admin)
    click_on 'Disciplinas'
    click_on discipline.title

    expect(page).to have_content('Não há conteúdos para serem exibidos.')
  end
end
