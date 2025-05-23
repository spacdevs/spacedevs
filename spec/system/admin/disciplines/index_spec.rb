require 'rails_helper'

feature Admin::DisciplinesController do
  let(:admin) { create(:user, :with_profile, :admin) }
  let(:student) { create(:user, :with_profile, :student) }

  scenario 'admin sees disciplines already registered' do
    create_list(:user, 5)
    create(:discipline, title: 'Introdução a computação')

    login_as(admin)
    click_on 'Disciplinas'

    expect(page).to have_content('Introdução a computação')
  end

  scenario 'admin sees only 15 disciplines' do
    create_list(:discipline, 20)

    login_as(admin)
    visit admin_disciplines_path

    expect(page).to have_css('.discipline', count: 15)
  end

  scenario 'user tries to access a direct route and gets redirected to the home page' do
    student = create(:user, :with_profile, :student)

    login_as(student)
    visit admin_disciplines_path

    expect(current_path).to eq(root_path)
  end
end
