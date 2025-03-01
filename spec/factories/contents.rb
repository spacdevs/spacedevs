FactoryBot.define do
  factory :content do
    title { Faker::Lorem.words(number: 4) }
    body { Faker::Movie.quote }
    discipline
    kind { %i[text video].sample }
  end
end
