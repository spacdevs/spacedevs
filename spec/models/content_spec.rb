require 'rails_helper'

RSpec.describe Content, type: :model do
  context 'validates' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to belong_to(:discipline) }
    it { is_expected.to define_enum_for(:kind).with_values(text: 0, video: 1) }
  end
end
