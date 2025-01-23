require 'rails_helper'

RSpec.describe Content, type: :model do
  context 'validates' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to define_enum_for(:kind).with_values(text: 0, video: 1) }
  end

  context 'association' do
    it { is_expected.to belong_to(:discipline) }
  end

  context 'should set available attribute' do
    let(:content)   do
      travel_to Time.zone.local(2024, 12, 31, 12, 0, 0) do
        create(:content)
      end
    end

    it { expect(content.available_on).to be_present }
    it { expect(I18n.l(content.available_on, format: :short)).to eq "31 de dezembro, 12:00" }
  end

  context 'when has slug' do
    let(:content) { create(:content, title: 'Hello World') }

    it 'should be present' do
      expect(content.slug).to be_present
      expect(content.slug).to eq('hello-world')
    end
  end

  context 'when updates slug' do
    let(:content) { create(:content, title: 'Hello World') }

    before do
      content.update!(title: 'Introduction the ruby lang')
    end

    it 'should be changed successfully' do
      expect(content.slug).to be_present
      expect(content.slug).to eq('introduction-the-ruby-lang')
    end
  end
end
