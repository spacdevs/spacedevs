# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User", type: :routing do
  context "GET /admin/disciplines" do
    it do
      expect(get: "/admin/disciplines").to route_to(
        controller: "admin/disciplines",
        action: "index"
      )
    end
  end
end
