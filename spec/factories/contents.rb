FactoryBot.define do
  factory :content do
    title   { Faker::Movie.title    }
    resume  { Faker::Lorem.sentence }
  end
end
