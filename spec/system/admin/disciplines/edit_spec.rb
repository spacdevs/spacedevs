require 'rails_helper'

feature Admin::DisciplinesController do
  let(:admin_user) { create(:user, :with_profile, :admin) }
  let!(:discipline) { create(:discipline) }

  before do
    team1 = create(:team, name: 'Colégio Estadual Roberto Santos - Turma 01')
    discipline.teams << [team1]
    discipline.save!

    login_as(admin_user)
    visit admin_disciplines_path
  end

  context 'when edit the discipline' do
    let!(:team) { create(:team, name: 'Colégio Estadual Deputado Luis Eduardo Magalhaes - Turma 03') }

    before do
      visit admin_disciplines_path
      find('a[title="Editar"]').click
      fill_in 'Título', with: 'Introdução a computação - Segunda edição'
      find("input[name='discipline[abstract]']", visible: false).set('Resumo da Segunda Edição')
      find("input[name='discipline[body]']", visible: false).set('Conteúdo da disciplina')
      fill_in  'Disponível em', with: Time.zone.local(2025, 12, 1, 9, 0, 0)
      fill_in  'Posição', with: '2'
      find(:css, "#discipline_team_ids_#{team.id}[value='#{team.id}']").set(true)
    end

    scenario 'edits discipline' do
      attach_file 'Recursos', Rails.root.join('spec/fixtures/resources.zip')
      click_on 'Atualizar Disciplina'
      discipline.reload

      expect(discipline.reload.resources.attached?).to be_truthy
      expect(discipline.title).to eq('Introdução a computação - Segunda edição')
      expect(discipline.abstract.to_plain_text).to eq('Resumo da Segunda Edição')
      expect(discipline.body.to_plain_text).to eq('Conteúdo da disciplina')
      expect(I18n.l(discipline.available_on, format: :short)).to eq('01 de dezembro, 09:00')
      expect(discipline.position).to eq(2)
      expect(discipline.teams.first.name).to eq('Colégio Estadual Roberto Santos - Turma 01')
      expect(discipline.teams.last.name).to eq('Colégio Estadual Deputado Luis Eduardo Magalhaes - Turma 03')
      expect(page).to have_content('Registro atualizado com sucesso.')
    end

    scenario 'When discipline has been updated without a resource, it must not remove the files' do
      file = Rails.root.join('spec/fixtures/resources.zip').open
      discipline.resources.attach(io: file, filename: 'resource.zip', content_type: 'application/zip')

      click_on 'Atualizar Disciplina'
      discipline.reload

      expect(page).to have_content('Registro atualizado com sucesso.')
      expect(discipline.reload.resources.attached?).to be_truthy
    end
  end

  xscenario 'remove all associate teams' do
    team = Team.first

    find('a[title="Editar"]').click
    find(:css, "#discipline_team_ids_#{team.id}[value='#{team.id}']").set(false)
    click_on 'Atualizar Disciplina'

    expect(discipline.reload.teams.count).to eq(0)
    expect(page).to have_content('Registro atualizado com sucesso.')
  end
end
