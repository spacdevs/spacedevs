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
  context 'GET /admin/teams/new' do
    it do
      expect(get: '/admin/teams/new').to route_to(
        controller: 'admin/teams',
        action: 'new'
      )
    end
  end
  context 'POST /admin/teams' do
    it do
      expect(post: '/admin/teams').to route_to(
        controller: 'admin/teams',
        action: 'create'
      )
    end
  end
  context 'GET /admin/teams/1/edit' do
    it do
      expect(get: '/admin/teams/1/edit').to route_to(
        controller: 'admin/teams',
        action: 'edit',
        id: '1'
      )
    end
  end
end
