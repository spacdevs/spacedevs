require 'rails_helper'

RSpec.describe UserSchoolEnrollments, type: :model do
  context 'associations' do
    it { is_expected.to validate_presence_of(:degree).with_message('não pode ficar em branco') }
  end

  context 'degrees' do
    it { is_expected.to define_enum_for(:degree).with_values(first_year: 1, second_year: 2, third_year: 3) }
  end
end
