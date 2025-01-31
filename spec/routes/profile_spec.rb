# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Content", type: :routing do
  context "GET /profile/john-doe" do
    it do
      expect(get: "/perfil").to route_to(
        controller: "profiles",
        action: "show"
      )
    end
  end
end
