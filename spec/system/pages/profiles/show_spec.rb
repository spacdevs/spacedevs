require 'rails_helper'

feature 'Visit profile' do
  let(:user) { create(:user, :with_profile) }

  before do
    user.profile.update!(birthday: Date.new(2000, 1, 1), degree: :first_year)
    login_as(user)
    click_on 'Meu perfil'
  end

  scenario { expect(current_path).to eq(profile_path) }

  scenario { have_content(user.profile.fullname) }

  scenario { have_content("E-mail: #{user.email}") }

  scenario { have_content("Matricula: #{user.registration_code}") }

  scenario { expect(current_path).to eq(profile_path) }

  scenario { have_content("Escola matriculada: #{user.school.name}") }

  scenario { have_content("Turma: 1º ano do ensino médio") }
end
