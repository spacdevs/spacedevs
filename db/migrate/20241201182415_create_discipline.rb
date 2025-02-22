class CreateDiscipline < ActiveRecord::Migration[8.0]
  def change
    create_table :disciplines do |t|
      t.string  :title,    index: { unique: true }
      t.string  :abstract, limit: 120
      t.integer :position, default: 1
      t.string  :slug, index: { unique: true }
      t.text    :body
      t.datetime :available_on, :datetime
      t.timestamps
    end
  end
end
