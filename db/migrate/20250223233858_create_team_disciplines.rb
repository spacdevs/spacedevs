class CreateTeamDisciplines < ActiveRecord::Migration[8.0]
  def change
    create_table :team_disciplines do |t|
      t.references :discipline, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
