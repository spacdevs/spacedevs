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

  context 'when is successfully' do
    before do
      fill_in 'Título', with: 'INTRODUÇÃO A LINGUAGEM PYTHON'
      find("input[name='content[body]']", visible: false).set('Aula de Python')

      select 'Vídeo', from: 'Tipo'
      click_on 'Atualizar Conteúdo'
    end

    scenario 'admin updates content' do
      expect(page).to have_content('INTRODUÇÃO A LINGUAGEM PYTHON')
      expect(content.reload.body.to_plain_text).to eq 'Aula de Python'
      expect(content.reload.video?).to be_truthy
    end
  end

  context 'when exists fails in process' do
    before do
      fill_in 'Título', with: ''
      find("input[name='content[body]']", visible: false).set(' ')
      select 'Vídeo', from: 'Tipo'
      click_on 'Atualizar Conteúdo'
    end

    scenario do
      expect(page).to have_content('Título não pode ficar em branco')
      expect(page).to have_content('Conteúdo não pode ficar em branco')
    end
  end
end
