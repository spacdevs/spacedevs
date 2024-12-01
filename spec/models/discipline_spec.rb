require 'rails_helper'

RSpec.describe Discipline, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:abstract)
  }
    it { is_expected.to validate_uniqueness_of(:title) }
  end
end
