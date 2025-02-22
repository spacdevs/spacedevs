class CreateContents < ActiveRecord::Migration[8.0]
  def change
    create_table :contents do |t|
      t.string     :title
      t.text       :body
      t.references :discipline, null: false, foreign_key: true
      t.integer    :kind, default: 1
      t.string :slug, index: { unique: true }

      t.timestamps
    end
  end
end
