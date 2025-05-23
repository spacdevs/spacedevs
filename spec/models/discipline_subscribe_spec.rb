require 'rails_helper'

RSpec.describe DisciplineSubscribe, type: :model do
  context 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:discipline) }
  end
end
