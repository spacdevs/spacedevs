class AddSlugToDisciplines < ActiveRecord::Migration[8.0]
  def change
    add_column :disciplines, :slug, :string
    add_index :disciplines, :slug, unique: true
  end
end
