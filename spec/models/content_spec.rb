require 'rails_helper'

RSpec.describe Content, type: :model do
  context 'validates' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to belong_to(:discipline) }
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
end
