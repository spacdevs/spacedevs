require 'rails_helper'

feature :disciplines do
  let(:user) { create(:user, :with_profile, :student) }
  let!(:discipline) { create(:discipline, :with_contents, position: 4) }

  before do
    create(:discipline_subscriber, discipline: discipline, user: user)

    login_as user
  end

  scenario 'view discipline title' do
    visit root_path
    click_on 'Continuar'

    expect(page).to have_content(discipline.title)
  end

  scenario 'student sees contents in the correct order of their position' do
    create(:content, discipline: discipline, title: 'Content 1', position: 1)
    create(:content, discipline: discipline, title: 'Content 3', position: 3)
    create(:content, discipline: discipline, title: 'Content 2', position: 2)

    visit discipline_path(discipline.slug)

    within '.topic-item:nth-child(2)' do
      expect(page).to have_content('Content 1')
    end

    within '.topic-item:nth-child(3)' do
      expect(page).to have_content('Content 2')
    end

    within '.topic-item:nth-child(4)' do
      expect(page).to have_content('Content 3')
    end

    discipline.contents.each do |content|
      expect(page).to have_content(content.title)
    end
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
