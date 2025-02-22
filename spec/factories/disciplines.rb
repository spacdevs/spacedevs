FactoryBot.define do
  factory :discipline do
    title { Faker::Lorem.paragraphs(number: 6) }
    body { Faker::Lorem.sentence }
    abstract { Faker::Lorem.sentence }
    available_on { 5.days.after }

    trait :with_contents do
      transient do
        limit { 1 }
      end

      after(:create) do |discipline, transient|
        create_list(:content, transient.limit, :text, discipline: discipline)
      end
    end

    trait :have_users do
      transient do
        size { 2 }
      end

      after :create do |discipline, transient|
        create_list(:user, transient.size, disciplines: [ discipline ])
      end
    end
  end
end
