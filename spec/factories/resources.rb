FactoryBot.define do
  factory :resource do
    name { Faker::File.file_name }
    url  { Faker::Internet.url }
    sourceable { nil }
  end

  trait :with_discipline do
    association :sourceable, factory: :discipline
  end

  trait :with_content do
    association :sourceable, factory: :discipline
  end
end
