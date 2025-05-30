require 'rails_helper'

feature :contents do
  let(:user) { create(:user, :with_profile, :student) }
  let(:discipline) { create(:discipline, :with_contents, position: 4) }
  let(:current_content) { discipline.contents.last }

  before do
    create(:discipline_subscriber, discipline: discipline, user: user)

    login_as user
  end

  scenario 'click and show introduction text' do
    visit root_path
    click_on 'Continuar'

    expect(page).to have_content(discipline.body.to_plain_text)
  end

  scenario 'student sees contents in the correct order of their position' do
    content = create(:content, discipline: discipline, title: 'Introducation to Github', position: 1)
    create(:content, discipline: discipline, title: 'Content 3', position: 3)
    create(:content, discipline: discipline, title: 'Content 2', position: 2)

    visit discipline_content_path(discipline_slug: discipline.slug, content_slug: content.slug)

    expect(page).to have_content('Introducation to Github')

    within '.topic-item.completed' do
      expect(page).to have_content('Introducation to Github')
    end

    within '.topic-item:nth-child(3)' do
      expect(page).to have_content('Content 2')
    end

    within '.topic-item:nth-child(4)' do
      expect(page).to have_content('Content 3')
    end
  end

  scenario 'must contain discipline title on each page' do
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

  scenario 'student view attachments' do
    file = Rails.root.join('spec/fixtures/resources.zip').open
    resource = create(:resource, name: 'resource.zip', sourceable: discipline)
    resource.file.attach(io: file, filename: 'resource.zip', content_type: 'application/zip')

    visit discipline_path(discipline.slug)

    expect(page).to have_content 'Materiais da Aula'
    expect(page).to have_content 'resource.zip'
    expect(page).to have_content '0.0 MB'
  end

  scenario 'must redirect to a 404 page' do
    visit discipline_path(slug: 'not_found')

    expect(current_path).to eq root_path
  end
end
