require 'rails_helper'

feature 'Visit profile' do
  before do
    login_as(user)
  end

  context 'when have profile' do
    let(:user) { create(:user, :with_profile) }

    before do
      user.profile.update!(birthday: Date.new(2000, 1, 1))
      create(:user_school_enrollments, degree: :first_year, school: user.school, user: user)
      click_on 'Meu perfil'
    end

    scenario { expect(current_path).to eq(profile_path) }

    scenario 'can view profile' do
      expect(page).to have_content("E-mail: #{user.email}")
      expect(page).to have_content("Matricula: #{user.registration_code}")
      expect(page).to have_content("Escola matriculada: #{user.school.name}")
      expect(page).to have_content('Turma: 1º ano do ensino médio')
    end
  end

  context 'when no profile' do
    let(:user) { create(:user, :student) }

    before do
      visit profile_path
    end

    scenario { expect(current_path).not_to eq(profile_path) }
    scenario { expect(current_path).to eq(root_path) }

    scenario 'cannot view profile' do
      expect(page).to have_content('Sem nome')
      expect(page).to have_content('Meu perfil')
      expect(page).to have_content('Sair')
    end
  end
end
