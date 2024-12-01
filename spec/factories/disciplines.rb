FactoryBot.define do
  factory :discipline do
    title     { Faker::Movie.title    }
    abstract  { Faker::Lorem.sentence }
  end
end
