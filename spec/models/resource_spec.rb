require 'rails_helper'

RSpec.describe Resource, type: :model do
  context 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_one_attached(:file) }
  end

  context 'association' do
    it { is_expected.to belong_to(:sourceable) }
  end

  context 'attachments' do
    it 'can have a file attached' do
      resource = Resource.new(name: 'Enrollment Scrum')
      resource.file.attach(
        io: StringIO.new('sample content'),
        filename: 'enrollments.txt',
        content_type: 'text/plain'
      )

      expect(resource.file).to be_attached
      expect(resource.file.filename.to_s).to eq 'enrollments.txt'
    end
  end
end
