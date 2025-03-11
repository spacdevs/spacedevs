require 'rails_helper'

RSpec.describe 'Teams', type: :routing do
  context 'GET /admin/teams' do
    it do
      expect(get: '/admin/teams').to route_to(
        controller: 'admin/teams',
        action: 'index'
      )
    end
  end
end
