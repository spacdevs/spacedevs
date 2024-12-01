class CreateDiscipline < ActiveRecord::Migration[8.0]
  def change
    create_table :disciplines do |t|
      t.string :title,    index: { unique: true }
      t.string :abstract, limit: 120

      t.timestamps
    end
  end
end
