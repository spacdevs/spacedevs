require "rails_helper"

RSpec.describe "Contents", type: :routing do
  context "GET /disciplina" do
    it { expect(get: "/disciplinas/1/conteudos/1").to route_to(controller: "contents", action: "show", discipline_id: "1", id: "1") }
  end
end
