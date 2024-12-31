#  Create the disciplines and contents that will be used in the application.

discipline = FactoryBot.create(:discipline, title: 'Introdução a linguagem GO')
FactoryBot.create_list(:content, 5, discipline: discipline, kind: :text)
FactoryBot.create(:user, email_address: 'student@spacedevs.com.br', password: '123', role: :student, registration_code: 'SDS6658093H')
FactoryBot.create(:user, email_address: 'manager@spacedevs.com.br', password: '123', role: :manager)
