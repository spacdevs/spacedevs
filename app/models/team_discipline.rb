class TeamDiscipline < ApplicationRecord
  belongs_to :discipline
  belongs_to :team
end
