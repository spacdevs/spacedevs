FactoryBot.define do
  factory :school do
    name { Faker::Educator.secondary_school }
    enable { true }
  end

  trait :with_user_school_enrollments do
    before :create do |school|
      create(:user_school_enrollments, school: school)
    end
  end
end
