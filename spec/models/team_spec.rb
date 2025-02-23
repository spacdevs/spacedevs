require 'rails_helper'

RSpec.describe Team, type: :model do
  context 'validates' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
