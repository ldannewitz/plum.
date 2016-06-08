class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name, { null: false }
      t.string :last_name, { null: false }
      t.string :email, { null: false, unique: true }
      t.string :password_digest, { null: false }
      t.text :auth_token, { null: false }
      t.string :phone

      t.timestamps null: false
    end
  end
end
