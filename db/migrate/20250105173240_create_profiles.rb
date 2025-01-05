class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :document, null: false
      t.string :avatar
      t.datetime :birthday, null: false
      t.integer :degree
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
