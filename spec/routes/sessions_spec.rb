require "rails_helper"

RSpec.describe "Sessions", type: :routing do
  context "GET /session/new" do
    it { expect(get: "session/new").to route_to(controller: "sessions", action: "new") }
  end

  context "Post /session/new" do
    it { expect(post: "session").to route_to(controller: "sessions", action: "create") }
  end

  context "Delete /session/destroy" do
    it { expect(delete: "session").to route_to(controller: "sessions", action: "destroy") }
  end
end
