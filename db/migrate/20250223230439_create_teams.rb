class CreateTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
