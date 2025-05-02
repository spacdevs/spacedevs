class RemoveDegreeFromProfile < ActiveRecord::Migration[8.0]
  def change
    remove_column :profiles, :degree, :integer
  end
end
