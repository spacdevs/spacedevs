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

  trait :subscribers_on_discipline do
    before :create do |user|
      discipline = create(:discipline, :with_contents)
      create(:discipline_subscriber, user_id: user.id, discipline_id: discipline.id)
    end
  end
end
