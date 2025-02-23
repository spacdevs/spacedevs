require 'rails_helper'

RSpec.describe TeamUser, type: :model do
  context 'association' do
    it { is_expected.to belong_to(:team) }
    it { is_expected.to belong_to(:user) }
  end
end
