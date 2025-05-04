class AddVideoIdToContents < ActiveRecord::Migration[8.0]
  def change
    add_column :contents, :video_id, :string
  end
end
