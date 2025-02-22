FactoryBot.define do
  factory :user do
    registration_code { "SD#{Faker::Code.nric}" }
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

  trait :have_disciplines do
    transient do
      size { 2 }
    end

    after :create do |user, transient|
      create_list(:discipline, transient.size, users: [ user ])
    end
  end
end
