class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string     :email_address,     null: false
      t.string     :registration_code, null: false
      t.integer    :role,              null: false, default: 0
      t.string     :password_digest,   null: false
      t.datetime   :disabled_at, null: true

      t.timestamps
    end
    add_index :users, :email_address, unique: true
    add_index :users, :registration_code, unique: true
  end
end
