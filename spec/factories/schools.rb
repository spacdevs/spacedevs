FactoryBot.define do
  factory :school do
    name { Faker::Educator.secondary_school }
    enable { true }
  end
end
