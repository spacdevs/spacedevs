FactoryBot.define do
  factory :user do
    registration_code { "SD#{Faker::Code.nric}" }
    email_address     { Faker::Internet.email }
    password          { Faker::Internet.password }
    school
  end

  trait :with_profile do
    before :create do |user|
      user.profile = create(:profile, user: user)
    end
  end
end
