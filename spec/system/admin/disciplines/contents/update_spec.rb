require 'rails_helper'

feature Admin::Disciplines::ContentsController do
  let(:admin) { create(:user, :with_profile, :admin) }
  let(:content) { create(:content, :with_discipline) }
  let!(:discipline) { content.discipline }

  before do
    login_as(admin)
    click_on 'Disciplinas'
    click_on discipline.title
    find('a[title="edit"]').click
  end

  context 'when is successfully' do
    before do
      fill_in 'Título', with: 'Introdução a linguagem Python'
      fill_in 'Conteúdo', with: 'Nesta aula você aprenderá os princípios básicos da linguagem Python.'
      select  'Vídeo', from: 'Tipo'
      click_on 'Atualizar Conteúdo'
      content.reload
    end

    scenario 'admin updates content' do
      expect(page).to have_content('Introdução a linguagem Python')
      expect(content.body).to eq 'Nesta aula você aprenderá os princípios básicos da linguagem Python.'
      expect(content.video?).to be_truthy
    end

    scenario 'admin cannot updated content' do
      expect(page).to have_content('Introdução a linguagem Python')
      expect(content.body).to eq 'Nesta aula você aprenderá os princípios básicos da linguagem Python.'
      expect(content.video?).to be_truthy
    end
  end

  context 'when exists fails in process' do
    before do
      fill_in 'Título', with: ''
      fill_in 'Conteúdo', with: ''
      select  'Vídeo', from: 'Tipo'
      click_on 'Atualizar Conteúdo'
    end

    scenario { expect(page).to have_content('Título não pode ficar em branco') }

    scenario { expect(page).to have_content('Conteúdo não pode ficar em branco') }
  end
end
