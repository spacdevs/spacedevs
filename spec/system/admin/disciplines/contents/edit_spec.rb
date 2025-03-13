require 'rails_helper'

feature Admin::Disciplines::ContentsController do
  let(:admin) { create(:user, :with_profile, :admin) }
  let!(:content) { create(:content, :with_discipline) }

  before do
    login_as(admin)
    click_on 'Disciplinas'
    click_on 'Editar'
  end

  scenario 'admin sees disciplines already registered' do
    expect(page).to have_field('Título')
    expect(page).to have_field('Conteúdo')
  end
end
