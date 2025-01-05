require 'rails_helper'

feature 'Disciplines' do
  scenario 'student must see fullname' do
    user = create(:user, :with_profile, :student)

    login_as(user)
    visit root_path

    expect(page).to have_content(user.profile.fullname)
  end

  context 'student without profile configured' do
    let(:user) { create(:user, :student) }

    before do
      login_as(user)
      visit root_path
    end

    scenario 'cannot see profile information' do
      create(:discipline, title: 'Introdução a tecnologia', abstract: 'Tudo sobre tecnologia')

      expect(page).to have_content('Sem nome')
      expect(page).to have_content('Configurações')
      expect(page).to have_content('Sair')
    end

    scenario 'cannot see disciplines information' do
      expect(page).not_to have_content('Introdução a tecnologia')
      expect(page).not_to have_content('Tudo sobre tecnologia')
      expect(page).to have_content('Termine de configurar seu perfil para ter acesso ao conteúdo')
    end
  end

  scenario 'student must see disciplines' do
    user = create(:user, :with_profile, :student)
    create(:discipline, title: 'Introdução a tecnologia', abstract: 'Neste módulo você aprenderá sobre a história da tecnologia e sua importância para a sociedade.')

    login_as(user)
    visit root_path

    expect(page).to have_content('Introdução a tecnologia')
    expect(page).to have_content('Neste módulo você aprenderá sobre a história da tecnologia e sua importância para a sociedade.')
  end

  scenario 'student must see disciplines in order' do
    user = create(:user, :with_profile, :student)
    discipline = create(:discipline, title: 'Introdução a tecnologia', position: 2)
    discipline2 = create(:discipline, title: 'Arquitetura de computadores', position: 1)

    login_as(user)
    visit root_path

    within '#disciplines > div:nth-child(2)' do
      expect(page).to have_content(discipline.title)
    end
    within '#disciplines > div:nth-child(1)' do
      expect(page).to have_content(discipline2.title)
    end
  end

  scenario 'student should see the message nothing to display' do
    user = create(:user, :with_profile, :student)

    login_as(user)
    visit root_path

    expect(page).to have_content('Estamos trabalhando no conteúdo para te ofertar, enquanto isso descanse 😁')
  end
end
