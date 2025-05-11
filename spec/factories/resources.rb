FactoryBot.define do
  factory :resource do
    name { Faker::File.file_name }
    url  { Faker::Internet.url }
    sourceable { nil }
  end
end
