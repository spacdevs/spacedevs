require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'validates' do
    it { is_expected.to validate_presence_of(:first_name).with_message('não pode ficar em branco') }
    it { is_expected.to validate_presence_of(:last_name).with_message('não pode ficar em branco') }
    it { is_expected.to validate_presence_of(:birthday).with_message('não pode ficar em branco') }
    it { is_expected.to validate_presence_of(:degree).with_message('não pode ficar em branco') }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'enums' do
    it { is_expected.to define_enum_for(:degree).with_values(first_year: 1, second_year: 2, third_year: 3) }
  end

  context 'when the user have avatar' do
    let(:profile) { create(:profile) }

    it { expect(profile.avatar).to be_present }
    it { expect(profile.avatar).to include('gravatar') }
  end

  context '#fullname' do
    let(:profile) { create(:profile, first_name: 'John', last_name: 'Doe') }

    it { expect(profile.fullname).to eq 'John Doe' }
  end
end