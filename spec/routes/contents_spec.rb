require "rails_helper"

RSpec.describe "Contents", type: :routing do
  context "GET /disciplina" do
    let(:discipline_slug) { 'human-machine-interface' }
    let(:content_slug) { 'introduction' }
    let(:uri) { "/disciplinas/#{discipline_slug}/conteudos/#{content_slug}" }

    it do
      expect(get: uri).to route_to(controller: "contents", action: "show", discipline_slug: discipline_slug, slug: content_slug)
    end
  end
end
