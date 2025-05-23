require 'rails_helper'

feature Admin::DisciplinesController do
  let(:admin_user) { create(:user, :with_profile, :admin) }
  let!(:discipline) { create(:discipline) }

  before do
    discipline.save!

    login_as(admin_user)
    visit admin_disciplines_path
  end

  context 'when edit the discipline' do
    before do
      visit admin_disciplines_path
      find('a[title="Editar"]').click
      fill_in 'Título', with: 'Introdução a computação - Segunda edição'
      find("input[name='discipline[abstract]']", visible: false).set('Resumo da Segunda Edição')
      find("input[name='discipline[body]']", visible: false).set('Conteúdo da disciplina')
      fill_in  'Disponível em', with: Time.zone.local(2025, 12, 1, 9, 0, 0)
      fill_in  'Posição', with: '2'
    end

    scenario 'edits discipline' do
      click_on 'Atualizar Disciplina'
      discipline.reload

      expect(discipline.title).to eq('Introdução a computação - Segunda edição')
      expect(discipline.abstract.to_plain_text).to eq('Resumo da Segunda Edição')
      expect(discipline.body.to_plain_text).to eq('Conteúdo da disciplina')
      expect(I18n.l(discipline.available_on, format: :short)).to eq('01 de dezembro, 09:00')
      expect(discipline.position).to eq(2)
      expect(page).to have_content('Registro atualizado com sucesso.')
    end
  end
end
