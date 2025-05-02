FactoryBot.define do
  factory :profile do
    fullname   { Faker::Name.name }
    document   { Faker::IdNumber.brazilian_citizen_number }
    avatar     { Faker::Avatar.image }
    birthday   { Faker::Date.birthday }
    whatsapp   { Faker::PhoneNumber.cell_phone }
    user
  end
end
