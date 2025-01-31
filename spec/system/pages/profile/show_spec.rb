require 'rails_helper'

feature 'Visit profile' do
  let(:user) { create(:user, :with_profile) }

  before do
    login_as(user)
    user.profile.update!(birthday: Date.new(2000, 1, 1), degree: :first_year)
  end

  scenario 'must showing profile informations' do
    click_on 'Meu perfil'

    expect(current_path).to eq(profile_path(user.profile.slug))
    expect(page).to have_content(user.profile.fullname)
    expect(page).to have_content("E-mail: #{user.email}")
    expect(page).to have_content("Idade: #{user.profile.age} anos")
    expect(page).to have_content("Matricula: #{user.registration_code}")
    expect(page).to have_content("Escola matriculada: #{user.school.name}")
    expect(page).to have_content("Turma: 1º ano do ensino médio")
  end
end
