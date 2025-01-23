# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Content", type: :routing do
  context "GET /disciplina/intro/aula/install-vim" do
    it do
      expect(get: "/disciplina/introducao/aula/instalando-vim").to route_to(
        controller: "contents",
        action: "show",
        discipline_slug: "introducao",
        content_slug: "instalando-vim"
      )
    end
  end
end
