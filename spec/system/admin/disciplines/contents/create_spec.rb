require 'rails_helper'

feature 'Admin::Disciplines::ContentsController' do
  let(:admin_user) { create(:user, :with_profile, :admin) }
  let!(:discipline) { create(:discipline) }

  before do
    login_as admin_user
    click_on 'Administração'
    click_on 'Disciplinas'
    find("a[title='#{discipline.title}']").click

    click_on 'Adicionar conteúdo'
  end

  context 'with valid params' do
    let(:content) { discipline.contents.first }

    before do
      fill_in 'Título', with: 'Introdução a linguagem Python'
      find("input[name='content[body]']", visible: false).set('Aula de Python.')
      select 'Vídeo', from: 'Tipo'
      click_on 'Criar Conteúdo'
      discipline.reload
    end

    scenario 'creates content' do
      expect(page).to have_content('Introdução a linguagem Python')
      expect(content.body.to_plain_text).to eq 'Aula de Python.'
      expect(content.video?).to be_truthy
    end
  end

  context 'with invalid params' do
    before do
      fill_in 'Título', with: ''
      select  'Vídeo', from: 'Tipo'
      click_on 'Criar Conteúdo'
    end

    scenario { expect(page).to have_content('Título não pode ficar em branco') }

    scenario { expect(page).to have_content('Conteúdo não pode ficar em branco') }
  end
end
