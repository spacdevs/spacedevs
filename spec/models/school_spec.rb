require 'rails_helper'

RSpec.describe School, type: :model do
  context 'associations' do
    it { is_expected.to have_one(:user_school_enrollments) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
