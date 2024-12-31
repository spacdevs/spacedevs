FactoryBot.define do
  factory :content do
    title { Faker::Movie.title }
    body { Faker::Movie.quote }
    discipline
    kind { :text }
    available { Time.zone.now }
  end
end
