FactoryBot.define do
  factory :content do
    title { Faker::Lorem.sentence(word_count: 4) }
    body { Faker::Movie.quote }
    kind { %i[text video].sample }

    trait :with_discipline do
      before(:create) do |content|
        content.update(discipline: create(:discipline))
      end
    end
  end
end
