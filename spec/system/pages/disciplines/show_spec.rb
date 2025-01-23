require 'rails_helper'

feature :disciplines do
  let(:user) { create(:user, :with_profile, :student) }
  let!(:discipline) { create(:discipline, :with_contents) }

  before { login_as user }

  scenario 'student open discipline and see contents' do
    visit root_path
    click_on discipline.title

    discipline.contents.each do |content|
      expect(page).to have_content(content.title)
    end
    expect(page).to have_content(discipline.title)
  end

  scenario 'must redirect to a 404 page' do
    visit discipline_path(slug: 'not_found')

    expect(page).to have_http_status(:not_found)
  end
end
