require 'rails_helper'

RSpec.describe 'Sessions', type: :routing do
  context 'GET /' do
    it { expect(get: '/').to route_to(controller: 'dashboard', action: 'index') }
  end
end
