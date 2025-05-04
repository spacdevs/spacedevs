FactoryBot.define do
  factory :content do
    title     { Faker::Lorem.sentence(word_count: 4) }
    body      { Faker::Movie.quote }
    kind      { %i[text video].sample }
    position  { Faker::Number.between(from: 1, to: 20) }
    video_id  { Faker::Number.between(from: 1, to: 20) }
    discipline

    trait :with_discipline do
      before(:create) do |content|
        content.update(discipline: create(:discipline))
      end
    end
  end
end
