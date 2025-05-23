require 'rails_helper'

RSpec.describe DisciplineSubscriber, type: :model do
  context 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:discipline) }
  end
end
