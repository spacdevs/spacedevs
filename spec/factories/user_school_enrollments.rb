FactoryBot.define do
  factory :user_school_enrollments do
    period { 1 }
    degree { %i[first_year second_year third_year].sample }
    school
    user
  end
end
