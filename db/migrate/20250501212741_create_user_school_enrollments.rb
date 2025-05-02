class CreateUserSchoolEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :user_school_enrollments do |t|
      t.integer :period, default: 0
      t.integer :degree, default: 0
      t.references :school, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
