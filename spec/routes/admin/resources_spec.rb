# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resource, type: :routing do
  context 'GET /admin/resources' do
    it do
      expect(get: '/admin/resources').to route_to(
        controller: 'admin/resources',
        action: 'index'
      )
    end
  end
  context 'GET /admin/resources/new' do
    it do
      expect(get: '/admin/resources/new').to route_to(
        controller: 'admin/resources',
        action: 'new'
      )
    end
  end
  context 'POST /admin/resources' do
    it do
      expect(post: '/admin/resources').to route_to(
        controller: 'admin/resources',
        action: 'create'
      )
    end
  end
  context 'GET /admin/resources/1/edit' do
    it do
      expect(get: '/admin/resources/1/edit').to route_to(
        controller: 'admin/resources',
        action: 'edit',
        id: '1'
      )
    end
  end
end
