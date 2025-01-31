class AddSlugToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :slug, :string, null: false, index: { unique: true }
  end
end
