class AddPositionToDiscipline < ActiveRecord::Migration[8.0]
  def change
    add_column :disciplines, :position, :integer, default: 1
  end
end
