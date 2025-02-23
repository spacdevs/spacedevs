# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Team.name }
    active { false }
  end
end
