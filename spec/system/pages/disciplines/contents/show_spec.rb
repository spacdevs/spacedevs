require 'rails_helper'

feature :contents do
  let(:user) { create(:user, :with_profile, :student) }
  let!(:discipline) { create(:discipline, :with_contents, position: 4) }
  let(:current_content) { discipline.contents.last }

  before { login_as user }

  scenario 'click and show introduction text' do
    visit root_path
    click_on discipline.title

    expect(page).to have_content(discipline.body.to_plain_text)
  end

  scenario 'student sees contents in the correct order of their position' do
    content = create(:content, discipline: discipline, title: 'Introducation to Github', position: 1)
    create(:content, discipline: discipline, title: 'Content 3', position: 3)
    create(:content, discipline: discipline, title: 'Content 2', position: 2)

    visit discipline_content_path(discipline_slug: discipline.slug, content_slug: content.slug)

    # title of content in page
    expect(page).to have_content('Introducation to Github')

    within 'div.uk-width-1-3\@m > div.uk-card.uk-card-secondary.uk-card-body.uk-margin-bottom > ul > li:nth-child(1)' do
      expect(page).to have_content('Introducation to Github')
    end

    within 'div.uk-width-1-3\@m > div > ul > li:nth-child(2)' do
      expect(page).to have_content('Content 2')
    end

    within 'div.uk-width-1-3\@m > div > ul > li:nth-child(3)' do
      expect(page).to have_content('Content 3')
    end

    discipline.contents.each do |c|
      expect(page).to have_content(c.title)
    end
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
    expect(page).to have_content(current_content.body.to_plain_text)
  end

  scenario 'sees supplies' do
    file = Rails.root.join('spec/fixtures/resources.zip').open
    discipline.resources.attach(io: file, filename: 'resource.zip', content_type: 'application/zip')

    visit discipline_path(discipline.slug)

    expect(page).to have_content 'Materiais'
    expect(page).to have_content 'resource.zip'
  end

  scenario 'not found page' do
    visit discipline_path(slug: 'not_found')

    expect(page).to have_http_status(:not_found)
  end
end
