require 'rails_helper'

RSpec.describe TeamDiscipline, type: :model do
  context 'association' do
    it { is_expected.to belong_to(:team) }
    it { is_expected.to belong_to(:discipline) }
  end
end
