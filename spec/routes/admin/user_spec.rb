# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User", type: :routing do
  context "GET /admin/users" do
    it do
      expect(get: "/admin/users").to route_to(
        controller: "admin/users",
        action: "index"
      )
    end
  end
  context "GET /admin/users/1/edit" do
    it do
      expect(get: "/admin/users/1/edit").to route_to(
        controller: "admin/users",
        action: "edit",
        id: '1'
      )
    end
  end
  context "PUT /admin/users/1" do
    it do
      expect(put: "admin/users/1").to route_to(
        controller: "admin/users",
        action: "update",
        id: '1'
      )
    end
  end
  context "PATCH /admin/users/1" do
    it do
      expect(patch: "admin/users/1").to route_to(
        controller: "admin/users",
        action: "update",
        id: '1'
      )
    end
  end
end
