FactoryBot.define do
  factory :profile do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    document   { Faker::IdNumber.brazilian_citizen_number }
    avatar     { Faker::Avatar.image }
    birthday   { Faker::Date.birthday }
    degree     { %i[first_year second_year third_year].sample }
    user
  end
end
