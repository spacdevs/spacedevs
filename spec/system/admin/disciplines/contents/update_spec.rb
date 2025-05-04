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
      fill_in 'Posição', with: 5
      fill_in 'ID do vídeo', with: '121920988'
      click_on 'Atualizar Conteúdo'
      content.reload
    end

    scenario 'admin updates content' do
      visit admin_discipline_path(content.discipline)

      expect(page).to have_content('INTRODUÇÃO A LINGUAGEM PYTHON')
      expect(content.body.to_plain_text).to eq 'Aula de Python'
      expect(content.position).to eq 5
      expect(content.video?).to be_truthy
    end
  end

  context 'when exists fails in process' do
    before do
      fill_in 'Título', with: ''
      find("input[name='content[body]']", visible: false).set(' ')
      fill_in 'Posição', with: ''
      select 'Vídeo', from: 'Tipo'
      click_on 'Atualizar Conteúdo'
    end

    scenario do
      expect(page).to have_content('Título não pode ficar em branco')
      expect(page).to have_content('Posição não pode ficar em branco')
      expect(page).to have_content('Conteúdo não pode ficar em branco')
    end
  end
end
