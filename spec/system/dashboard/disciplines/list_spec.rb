require 'rails_helper'

feature 'Disciplines' do
  scenario 'student must see disciplines' do
    user = create(:user, :student)
    create(:discipline, title: 'Introdução a tecnologia', abstract: 'Neste módulo você aprenderá sobre a história da tecnologia e sua importância para a sociedade.')
    create(:discipline, title: 'Arquitetura de computadores', abstract: 'Neste módulo você aprenderá sobre a arquitetura de computadores e como eles funcionam.')

    login_as(user)
    visit root_path

    within '#disciplines > div:nth-child(1)' do
      expect(page).to have_content('Introdução a tecnologia')
      expect(page).to have_content('Neste módulo você aprenderá sobre a história da tecnologia e sua importância para a sociedade.')
    end
    within '#disciplines > div:nth-child(2)' do
      expect(page).to have_content('Arquitetura de computadores')
      expect(page).to have_content('Neste módulo você aprenderá sobre a arquitetura de computadores e como eles funcionam.')
    end
  end

  scenario 'student must see disciplines on ordered' do
    user = create(:user, :student)
    discipline = create(:discipline, title: 'Introdução a tecnologia',     position: 2)
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
    user = create(:user, :student)

    login_as(user)
    visit root_path

    expect(page).to have_content('Nenhuma disciplina disponível')
  end
end
