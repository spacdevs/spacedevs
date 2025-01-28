require "rails_helper"

RSpec.describe "Profiles", type: :routing do
  context "GET /profiles/:id/edit" do
    it { expect(get: "/profiles/1/edit").to route_to(controller: "profiles", action: "edit", id: "1") }
  end
end
