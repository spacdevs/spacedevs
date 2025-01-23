require 'rails_helper'

feature :contents do
  let(:user) { create(:user, :with_profile, :student) }
  let!(:discipline) { create(:discipline, :with_contents) }
  let(:current_content) { discipline.contents.last }

  before do
    login_as(user)
  end

  scenario 'click and show introduction text' do
    visit root_path
    click_on discipline.title

    expect(page).to have_content(discipline.body)
  end

  scenario 'must have contents' do
    visit discipline_path(discipline.slug)

    discipline.contents.each do |content|
      expect(page).to have_content(content.title)
    end
  end

  scenario 'click and show content' do
    visit discipline_path(discipline.slug)
    click_on current_content.title

    expect(page).to have_content(current_content.title)
    expect(page).to have_content(current_content.body)
  end
end
