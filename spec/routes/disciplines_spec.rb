require 'rails_helper'

RSpec.describe 'Discipline', type: :routing do
  context 'GET /disciplina' do
    it { expect(get: '/disciplina/intro').to route_to(controller: 'disciplines', action: 'show', slug: 'intro') }
  end
end
