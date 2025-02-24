require 'rails_helper'

feature 'Disciplines' do
  let!(:discipline) do
    create(:discipline, title: 'Introdução a tecnologia', abstract: 'Tudo sobre tecnologia', position: 2)
  end
  let(:user) { create(:user, :with_profile, :student) }

  before do
    login_as(user)
    visit root_path
  end

  scenario 'student must see fullname' do
    expect(page).to have_content(user.profile.fullname)
  end

  context 'when no profile' do
    let(:user) { create(:user, :student) }

    scenario 'cannot see profile information' do
      expect(page).to have_content('Sem nome')
      expect(page).to have_content('Meu perfil')
      expect(page).to have_content('Sair')
    end

    scenario 'cannot view disciplines' do
      expect(page).not_to have_content('Introdução a tecnologia')
      expect(page).not_to have_content('Tudo sobre tecnologia')
      expect(page).to have_content('Termine de configurar seu perfil para ter acesso ao conteúdo')
    end
  end

  context 'when have profile' do
    let!(:discipline2) { create(:discipline, position: 1) }

    before do
      user.update!(role: %i[student admin].sample)
      visit root_path
    end

    scenario 'view disciplines' do
      expect(page).to have_content('Introdução a tecnologia')
      expect(page).to have_content('Tudo sobre tecnologia')
      expect(page).not_to have_content('Termine de configurar seu perfil para ter acesso ao conteúdo')
    end

    scenario 'can view ordered disciplines' do
      within '#disciplines > div:nth-child(2)' do
        expect(page).to have_content(discipline.title)
      end
      within '#disciplines > div:nth-child(1)' do
        expect(page).to have_content(discipline2.title)
      end
    end
  end

  scenario 'student should see the message nothing to display' do
    Discipline.delete_all

    visit root_path

    expect(page).to have_content('Estamos trabalhando no conteúdo para te ofertar, enquanto isso acesse a nossa comunidade.')
  end
end
