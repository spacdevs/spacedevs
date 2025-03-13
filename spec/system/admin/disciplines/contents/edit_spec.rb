require 'rails_helper'

feature Admin::Disciplines::ContentsController do
  let(:admin) { create(:user, :with_profile, :admin) }
  let(:content) { create(:content, :with_discipline) }
  let!(:discipline) { content.discipline }

  before do
    login_as(admin)
    click_on 'Disciplinas'
    find('a[title="view the contents"]').click
    find('a[title="edit"]').click
  end

  scenario 'admin sees disciplines already registered' do
    expect(page).to have_field('Título')
    expect(page).to have_field('Conteúdo')
    expect(page).to have_select('Tipo')
  end
end
