require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validates' do
    it { is_expected.to validate_presence_of(:email_address) }
    it { is_expected.to validate_presence_of(:registration_code) }
    it { is_expected.to define_enum_for(:role).with_values(admin: 0, student: 1) }
  end

  context 'association' do
    it { is_expected.to belong_to(:school) }
    it { is_expected.to have_many(:sessions) }
    it { is_expected.to have_many(:teams) }
    it { is_expected.to have_one(:profile) }
  end

  context 'user is on multiple teams' do
    let(:user) { create(:user) }

    before do
      create_list(:team, 3, users: [user])
      user.reload
    end

    it { expect(user.teams.size).to eq(3) }
  end

  context '#normalizes' do
    let(:user) { create(:user, email_address: 'contato@spacedevs.com.br ', registration_code: ' ab1c4d5e ') }

    it 'normalize email_address and registration_code' do
      expect(user.reload.email_address).to eq('contato@spacedevs.com.br')
      expect(user.reload.registration_code).to eq('AB1C4D5E')
    end
  end

  context 'auto generate registration code' do
    let(:user) { build(:user, registration_code: nil) }

    it 'should generate when the user has been registrated' do
      expect { user.save }.to change(user, :registration_code)

      expect(user.registration_code).to be_present
    end
  end
end
