class CreateResource < ActiveRecord::Migration[8.0]
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.string :url
      t.references :sourceable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
