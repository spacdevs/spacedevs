# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Content", type: :routing do
  context "GET /profile/john-doe" do
    it do
      expect(get: "/profile/john-doe").to route_to(
        controller: "profiles",
        action: "show",
        slug: "john-doe",
      )
    end
  end
end
