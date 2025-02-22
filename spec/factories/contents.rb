FactoryBot.define do
  factory :content do
    title { Faker::Movie.title }
    body { Faker::Movie.quote }
    discipline
    kind { %i[text video].sample }
  end
end
