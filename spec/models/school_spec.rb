require 'rails_helper'

RSpec.describe School, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
