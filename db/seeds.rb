#  Create the disciplines and contents that will be used in the application.

discipline = FactoryBot.create(:discipline, title: 'Introdução a linguagem GO')
FactoryBot.create_list(:content, 5, discipline: discipline, kind: :text)
