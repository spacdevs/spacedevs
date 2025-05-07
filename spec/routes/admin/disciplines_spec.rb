# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User', type: :routing do
  context 'GET /admin/disciplines' do
    it do
      expect(get: '/admin/disciplines').to route_to(
        controller: 'admin/disciplines',
        action: 'index'
      )
    end
  end
  context 'GET /admin/disciplines/new' do
    it do
      expect(get: '/admin/disciplines/new').to route_to(
        controller: 'admin/disciplines',
        action: 'new'
      )
    end
  end
  context 'POST /admin/disciplines' do
    it do
      expect(post: '/admin/disciplines').to route_to(
        controller: 'admin/disciplines',
        action: 'create'
      )
    end
  end
  context 'GET /admin/disciplines/1/edit' do
    it do
      expect(get: '/admin/disciplines/1/edit').to route_to(
        controller: 'admin/disciplines',
        action: 'edit',
        id: '1'
      )
    end
  end
  context 'PATCH /admin/disciplines/1/sortable' do
    it do
      expect(patch: '/admin/disciplines/1/sortable').to route_to(
        controller: 'admin/disciplines',
        action: 'update_position',
        id: '1'
      )
    end
  end
end
