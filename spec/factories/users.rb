FactoryBot.define do
  factory :user do
    email_address     { Faker::Internet.email }
    password          { Faker::Internet.password }
    school
  end

  trait :with_profile do
    transient do
      fullname { Faker::Name.name }
    end

    before :create do |user, transient|
      user.profile = create(:profile, fullname: transient.fullname, user: user)
    end
  end

  trait :with_discipline_subscriber do
    before :create do |user|
      create(:discipline_subscriber, user: user, discipline: create(:discipline, :with_contents))
    end
  end
end
