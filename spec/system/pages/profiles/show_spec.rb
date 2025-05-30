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

    scenario 'has fullname' do
      expect(page).to have_content("Nome:\n#{user.profile.fullname}")
    end

    scenario 'has e-mail' do
      expect(page).to have_content("E-mail:\n#{user.email}")
    end

    scenario 'has whatsapp' do
      expect(page).to have_content("Telefone:\n#{user.profile.whatsapp}")
    end

    scenario 'has registration code' do
      expect(page).to have_content("Matricuka:\n#{user.registration_code}")
    end

    scenario 'Escola matriculada:' do
      expect(page).to have_content("Escola matriculada:\n#{user.school.name}")
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
      expect(page).not_to have_content('Meu perfil')
    end
  end
end
