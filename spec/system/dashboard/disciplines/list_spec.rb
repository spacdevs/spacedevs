require 'rails_helper'

feature 'Disciplines' do
  scenario 'student must view disciplines' do
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
end
