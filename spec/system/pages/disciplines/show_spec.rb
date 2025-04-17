require 'rails_helper'

feature :disciplines do
  let(:user) { create(:user, :with_profile, :student) }
  let!(:discipline) { create(:discipline, :with_contents, position: 4) }

  before { login_as user }

  scenario 'student open discipline and see contents' do
    visit root_path
    click_on discipline.title

    discipline.contents.each do |content|
      expect(page).to have_content(content.title)
    end
    expect(page).to have_content(discipline.title)
  end
  scenario 'student sees contents in the correct order of their position' do
    create(:content, discipline: discipline, title: 'Content 1', position: 1)
    create(:content, discipline: discipline, title: 'Content 3', position: 3)
    create(:content, discipline: discipline, title: 'Content 2', position: 2)

    visit discipline_path(discipline.slug)

    within 'div.uk-width-1-4\@m.uk-width-1-1\@s > div > ol > li:nth-child(1)' do
      expect(page).to have_content('Content 1')
    end

    within 'div.uk-width-1-4\@m.uk-width-1-1\@s > div > ol > li:nth-child(2)' do
      expect(page).to have_content('Content 2')
    end

    within 'div.uk-width-1-4\@m.uk-width-1-1\@s > div > ol > li:nth-child(3)' do
      expect(page).to have_content('Content 3')
    end

    discipline.contents.each do |content|
      expect(page).to have_content(content.title)
    end
  end

  scenario 'must redirect to a 404 page' do
    visit discipline_path(slug: 'not_found')

    expect(page).to have_http_status(:not_found)
  end
end
