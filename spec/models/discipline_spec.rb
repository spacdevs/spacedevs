require 'rails_helper'

RSpec.describe Discipline, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:abstract) }
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:available_on) }
  end

  context 'association' do
    it { is_expected.to have_many(:contents) }
    it { is_expected.to have_many(:teams) }
  end

  context 'discipline is on multiple teams' do
    let(:discipline) { create(:discipline) }

    before do
      create_list(:team, 3, disciplines: [ discipline ])
      discipline.reload
    end

    it { expect(discipline.teams.size).to eq(3) }
  end

  context 'should set available attribute' do
    let(:discipline) { create(:discipline, available_on: Time.zone.local(2024, 12, 31, 12, 0, 0)) }

    it { expect(discipline.available_on).to be_present }
    it { expect(I18n.l(discipline.available_on, format: :short)).to eq '31 de dezembro, 12:00' }
  end

  context '#discipline' do
    let(:discipline) { create(:discipline) }

    it 'position default must be 1' do
      expect(discipline.position).to eq(1)
    end
  end

  context 'when has slug' do
    let(:discipline) { create(:discipline, title: 'Hello World') }

    it 'should be present' do
      expect(discipline.slug).to be_present
      expect(discipline.slug).to eq('hello-world')
    end
  end

  context 'when updates slug' do
    let(:discipline) { create(:discipline, title: 'Hello World') }

    before do
      discipline.update!(title: 'Introduction the ruby lang')
    end

    it 'should be changed successfully' do
      expect(discipline.slug).to be_present
      expect(discipline.slug).to eq('introduction-the-ruby-lang')
    end
  end
end
