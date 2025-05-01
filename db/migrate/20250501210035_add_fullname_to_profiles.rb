class AddFullnameToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :fullname, :string
  end
end
