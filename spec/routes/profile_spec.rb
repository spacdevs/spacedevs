# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Content", type: :routing do
  context "GET /profile" do
    it do
      expect(get: "/perfil").to route_to(
        controller: "profiles",
        action: "show"
      )
    end
  end
  context "GET /profile/edit" do
    it do
      expect(get: "/perfil/edit").to route_to(
        controller: "profiles",
        action: "edit"
      )
    end
  end
end
