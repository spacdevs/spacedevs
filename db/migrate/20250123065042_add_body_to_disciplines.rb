class AddBodyToDisciplines < ActiveRecord::Migration[8.0]
  def change
    add_column :disciplines, :body, :text
  end
end
