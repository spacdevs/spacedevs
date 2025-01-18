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
end
