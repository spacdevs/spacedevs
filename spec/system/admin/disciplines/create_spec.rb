require 'rails_helper'

feature Admin::DisciplinesController do
  let(:admin_user) { create(:user, :with_profile, :admin) }
  let(:discipline) { Discipline.last }

  before do
    create(:team, name: 'Colégio Estadual Roberto Santos - Turma 01')
  end

  context 'when discipline has been created' do
    before do
      team = Team.first

      login_as(admin_user)
      click_on 'Admin'
      click_on 'Disciplinas'
      click_on 'Adicionar'
      fill_in  'Título', with: 'Introdução a computação'
      find("input[name='discipline[abstract]']", visible: false).set('Resumo da Segunda Edição')
      find("input[name='discipline[body]']", visible: false).set('Segunda Edição')
      fill_in  'Disponível em', with: Time.zone.local(2025, 10, 12, 12, 0, 0)
      fill_in  'Posição', with: '1'
      find(:css, "#discipline_team_ids_#{team.id}[value='#{team.id}']").set(true)
    end

    scenario 'successfully' do
      click_on 'Criar Disciplina'

      expect(current_path).to eq(admin_disciplines_path)
      expect(discipline.title).to eq('Introdução a computação')
      expect(discipline.abstract.to_plain_text).to eq('Resumo da Segunda Edição')
      expect(discipline.body.to_plain_text).to eq('Segunda Edição')
      expect(I18n.l(discipline.available_on, format: :short)).to eq('12 de outubro, 12:00')
      expect(page).to have_content('Disciplína criado(a) com sucesso.')
      expect(discipline.position).to eq(1)
      expect(discipline.teams.last.name).to eq('Colégio Estadual Roberto Santos - Turma 01')
    end
  end

  scenario 'creates without fields' do
    login_as(admin_user)
    click_on 'Admin'
    click_on 'Disciplinas'
    click_on 'Adicionar'
    click_on 'Criar Disciplina'

    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Resumo não pode ficar em branco')
    expect(page).to have_content('Conteúdo não pode ficar em branco')
    expect(page).to have_content('Disponível em não pode ficar em branco')
  end
end
