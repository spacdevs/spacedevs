require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validates' do
    it { is_expected.to validate_presence_of(:email_address) }
    it { is_expected.to validate_presence_of(:registration_code) }
    it { is_expected.to have_many(:sessions) }
    it { is_expected.to define_enum_for(:role).with_values(manager: 0, student: 1) }
    it { is_expected.to have_one(:profile) }
  end

  context 'auto generate registration code' do
    let(:user) { create(:user) }

    it 'should generate when the user has been registrated' do
      expect(user.registration_code).to be_present
    end
  end
end
