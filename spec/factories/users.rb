FactoryBot.define do
  factory :user do
    registration_code { "SD#{Faker::Code.nric}" }
    email_address     { Faker::Internet.email }
    password          { Faker::Internet.password }
  end
end
