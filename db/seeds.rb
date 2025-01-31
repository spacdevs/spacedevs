#  Create the disciplines and contents that will be used in the application.
FactoryBot.create(:discipline, :with_contents)

# Create users with different roles
FactoryBot.create(:user, :with_profile, email_address: 'student@spacedevs.com.br', password: '123', role: :student, registration_code: 'SDS6658093H')
FactoryBot.create(:user, :with_profile, email_address: 'manager@spacedevs.com.br', password: '123', role: :manager)
