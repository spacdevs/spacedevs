FactoryBot.define do
  factory :profile do
    fullname   { Faker::Name.name }
    document   { Faker::IdNumber.brazilian_citizen_number }
    avatar     { Faker::Avatar.image }
    birthday   { Faker::Date.birthday }
    degree     { %i[first_year second_year third_year].sample }
    user
  end
end
