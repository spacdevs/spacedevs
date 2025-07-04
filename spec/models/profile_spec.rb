require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'validates' do
    it { is_expected.to validate_presence_of(:fullname).with_message('não pode ficar em branco') }
    it { is_expected.to validate_presence_of(:birthday).with_message('não pode ficar em branco') }
    it { is_expected.to validate_presence_of(:whatsapp).with_message('não pode ficar em branco') }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'when the user have avatar' do
    let(:profile) { create(:profile) }

    it { expect(profile.avatar).to be_present }
    it { expect(profile.avatar).to include('gravatar') }
  end

  context '#slug' do
    let(:profile) { create(:profile, fullname: 'John Doe') }

    it { expect(profile.slug).to eq 'john-doe' }
  end

  context '#age' do
    let(:profile) { create(:profile, birthday: Time.zone.local(2000, 2, 1)) }

    before { travel_to Time.zone.local(2025, 1, 1) }

    it { expect(profile.age).to eq 24 }
  end
end
