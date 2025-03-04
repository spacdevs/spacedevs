require 'rails_helper'

RSpec.describe Team, type: :model do
  context 'association' do
    it { is_expected.to have_many(:users) }
  end

  context 'team has many users' do
    let(:team) { create(:team) }

    before do
      create_list(:user, 3, teams: [team])
    end

    it { expect(team.users.size).to eq(3) }
  end

  context 'team has many disciplines' do
    let(:team) { create(:team) }

    before do
      create_list(:discipline, 3, teams: [team])
    end

    it { expect(team.disciplines.size).to eq(3) }
  end
end
