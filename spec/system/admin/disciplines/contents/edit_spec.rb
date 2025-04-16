require 'rails_helper'

feature Admin::Disciplines::ContentsController do
  let(:admin) { create(:user, :with_profile, :admin) }
  let(:content) { create(:content, :with_discipline) }
  let!(:discipline) { content.discipline }

  before do
    login_as(admin)
    click_on 'Administração'
    click_on 'Disciplinas'
    find("a[title='#{discipline.title}']").click
    find('a[title="edit"]').click
  end

  scenario 'admin sees disciplines already registered' do
    expect(page).to have_field('Título')
    expect(page).to have_selector("trix-editor[input='content_body_trix_input_content_#{content.id}']")
    expect(page).to have_select('Tipo')
  end
end
