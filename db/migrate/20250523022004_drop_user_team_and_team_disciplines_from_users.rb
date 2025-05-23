class DropUserTeamAndTeamDisciplinesFromUsers < ActiveRecord::Migration[8.0]
  def change
    drop_table :team_users
    drop_table :team_disciplines
  end
end
