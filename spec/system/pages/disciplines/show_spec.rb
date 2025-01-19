require 'rails_helper'

feature :contents do
  scenario 'student open discipline and see contents' do
    user = create(:user, :with_profile, :student)
    discipline = create(:discipline, :with_contents)

    login_as(user)
    visit root_path
    click_on discipline.title

    discipline.contents.each do |content|
      expect(page).to have_content(content.title)
    end
    expect(page).to have_content(discipline.title)
  end

  scenario 'must redirect to a 404 page' do
    user = create(:user, :with_profile, :student)

    login_as(user)
    visit discipline_path(slug: 1)

    expect(status_code).to eq(404)
  end
end
