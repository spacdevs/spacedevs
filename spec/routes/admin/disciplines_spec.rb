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
end
