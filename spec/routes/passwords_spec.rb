# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Content', type: :routing do
  context 'POST /paswords' do
    it do
      expect(post: '/passwords').to route_to(
        controller: 'passwords',
        action: 'create'
      )
    end
  end
end
