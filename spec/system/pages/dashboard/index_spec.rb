require 'rails_helper'

feature 'Disciplines' do
  let(:user) { create(:user, :with_profile, :student) }
  let(:discipline) do
    create(:discipline, title: 'Introdução a tecnologia', abstract: 'Tudo sobre tecnologia', position: 2)
  end

  before do
    create(:discipline_subscriber, discipline: discipline, user: user)

    login_as(user)
    visit root_path
  end

  scenario 'student must see fullname' do
    expect(page).to have_content(user.profile.fullname)
  end

  context 'when visits the dashboard' do
    before do
      discipline = create(:discipline, position: 1, title: 'Criando funcões anônimas')
      create(:discipline_subscriber, discipline: discipline, user: user)

      visit root_path
    end

    scenario 'can view ordered disciplines' do
      within '#disciplines > div:nth-child(1)' do
        expect(page).to have_content('Criando funcões anônimas')
      end
      within '#disciplines > div:nth-child(2)' do
        expect(page).to have_content('Introdução a tecnologia')
      end
    end
  end

  context 'when visits see only disciplines associates' do
    let!(:discipline2) { create(:discipline, position: 1, title: 'Criando funcões anônimas') }

    before do
      create(:discipline_subscriber, discipline: discipline2, user: user)

      visit root_path
    end

    scenario 'can view ordered disciplines' do
      within '#disciplines > div:nth-child(1)' do
        expect(page).to have_content('Criando funcões anônimas')
      end
      within '#disciplines > div:nth-child(2)' do
        expect(page).to have_content('Introdução a tecnologia')
      end
    end
  end

  scenario 'student should see the message nothing to display' do
    DisciplineSubscriber.delete_all

    visit root_path

    expect(page).to have_content('Estamos trabalhando no conteúdo para te ofertar.')
  end
end
