FactoryBot.define do
  factory :user do
    email_address     { Faker::Internet.email }
    password          { Faker::Internet.password }
    school
  end

  trait :with_profile do
    transient do
      first_name { Faker::Name.first_name }
      last_name  { Faker::Name.last_name }
    end

    before :create do |user, transient|
      user.profile = create(:profile, first_name: transient.first_name, last_name: transient.last_name, user: user)
    end
  end
end
