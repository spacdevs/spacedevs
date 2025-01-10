require 'rails_helper'

RSpec.describe Discipline, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:abstract) }
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_uniqueness_of(:title) }
  end

  context 'association' do
    it { is_expected.to have_many(:contents) }
  end

  context '#discipline' do
    let(:discipline) { create(:discipline) }

    it 'position default must be 1' do
      expect(discipline.position).to eq(1)
    end
  end
end
