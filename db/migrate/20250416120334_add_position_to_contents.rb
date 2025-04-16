class AddPositionToContents < ActiveRecord::Migration[8.0]
  def change
    add_column :contents, :position, :integer, default: 1
  end
end
