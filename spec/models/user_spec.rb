require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validates' do
    it { is_expected.to validate_presence_of(:email_address) }
    it { is_expected.not_to validate_presence_of(:registration_code) }
    it { is_expected.to define_enum_for(:role).with_values(admin: 0, student: 1) }
  end

  context 'association' do
    it { is_expected.to belong_to(:school).optional }
    it { is_expected.to have_many(:sessions) }
    it { is_expected.to have_many(:teams) }
    it { is_expected.to have_one(:profile) }
    it { is_expected.to have_one(:user_school_enrollments) }
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
    let(:user) { create(:user, email_address: 'contato@spacedevs.com.br ') }

    before do
      allow(SecureRandom).to receive(:hex).with(4).and_return('83397BD6')
    end

    it 'normalize email_address and registration_code' do
      expect(user.reload.email_address).to eq('contato@spacedevs.com.br')
      expect(user.reload.registration_code).to eq('SD-83397BD6')
    end
  end

  context 'should create user as student' do
    let(:school) { create(:school) }
    let(:user) { User.create(email: 'test@localhost.com', password: 'AS98cC091!', school: school) }

    it 'must be not admin' do
      expect(user).not_to be_admin
    end

    it 'must be student student' do
      expect(user).to be_student
    end
  end

  context 'auto generate registration code' do
    let(:user) { build(:user, registration_code: nil) }

    it 'should generate when the user has been registrated' do
      expect { user.save }.to change(user, :registration_code)

      expect(user.registration_code).to be_present
    end
  end

  context 'when registered send welcome email' do
    let(:mailer_double) { double('WelcomeMailer', deliver_now: true) }

    before do
      allow(WelcomeMailer).to receive(:send_email).and_return(mailer_double)
      allow(mailer_double).to receive(:deliver_now)
    end

    it 'send e-mail when registered' do
      user = create(:user, :with_profile)
      expect(WelcomeMailer).to have_received(:send_email).with(user).exactly(1).times
      expect(mailer_double).to have_received(:deliver_now).once
    end
  end
end
