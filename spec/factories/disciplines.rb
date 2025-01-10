FactoryBot.define do
  factory :discipline do
    title     { Faker::Movie.title    }
    abstract  { Faker::Lorem.sentence }

    trait :with_contents do
      transient do
        limit { 3 }
      end

      after(:create) do |discipline, transient|
        create_list(:content, transient.limit, discipline: discipline)
      end
    end
  end
end
