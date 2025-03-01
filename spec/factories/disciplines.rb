FactoryBot.define do
  factory :discipline do
    title     { Faker::Lorem.words(number: 4) }
    body      { Faker::Lorem.sentence }
    abstract  { Faker::Lorem.sentence }
    available_on { 5.days.after }

    trait :with_contents do
      transient do
        limit { 1 }
      end

      after(:create) do |discipline, transient|
        create_list(:content, transient.limit, :text, discipline: discipline)
      end
    end
  end
end
