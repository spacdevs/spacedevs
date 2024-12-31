class AddAvailableToContent < ActiveRecord::Migration[8.0]
  def change
    add_column :contents, :available, :datetime
  end
end
