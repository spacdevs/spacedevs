class CreateDisciplineSubscribes < ActiveRecord::Migration[8.0]
  def change
    create_table :discipline_subscribes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :discipline, null: false, foreign_key: true

      t.timestamps
    end
  end
end
