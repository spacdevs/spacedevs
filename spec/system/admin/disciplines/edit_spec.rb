require 'rails_helper'

feature Admin::DisciplinesController do
  let(:admin_user) { create(:user, :with_profile, :admin) }
  let(:discipline) { create(:discipline) }

  before do
    team1 = create(:team, name: 'Colégio Estadual Roberto Santos - Turma 01')
    discipline.teams << [team1]
    discipline.save!

    login_as(admin_user)
    visit admin_disciplines_path
  end

  scenario 'edits discipline' do
    create(:team, name: 'Colégio Estadual Deputado Luis Eduardo Magalhaes - Turma 03')

    find('a[title="Editar"]').click
    fill_in  'Título', with: 'Introdução a computação - Segunda edição'
    fill_in  'Resumo', with: 'Resumo editado'
    fill_in  'Conteúdo', with: 'Conteúdo da disciplina'
    fill_in  'Disponível em', with: Time.zone.local(2025, 12, 1, 9, 0, 0)
    fill_in  'Posição', with: '2'
    find(:css, "#discipline_team_ids_2[value='2']").set(true)
    click_on 'Atualizar Disciplina'
    discipline.reload

    expect(discipline.title).to eq('Introdução a computação - Segunda edição')
    expect(discipline.abstract).to eq('Resumo editado')
    expect(discipline.body).to eq('Conteúdo da disciplina')
    expect(I18n.l(discipline.available_on, format: :short)).to eq('01 de dezembro, 09:00')
    expect(discipline.position).to eq(2)
    expect(discipline.teams.first.name).to eq('Colégio Estadual Roberto Santos - Turma 01')
    expect(discipline.teams.last.name).to eq('Colégio Estadual Deputado Luis Eduardo Magalhaes - Turma 03')
    expect(page).to have_content('Registro atualizado com sucesso.')
  end

  scenario 'remove all associate teams' do
    find('a[title="Editar"]').click
    find(:css, "#discipline_team_ids_1[value='1']").set(false)
    click_on 'Atualizar Disciplina'

    expect(discipline.reload.teams.count).to eq(0)
    expect(page).to have_content('Registro atualizado com sucesso.')
  end
end
