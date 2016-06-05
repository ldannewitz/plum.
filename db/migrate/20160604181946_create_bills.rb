class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.integer :event_id, { null: false }
      t.integer :user_id, { null: false }
      t.string :bill_type, { null: false }
      t.float :amount, { null: false, scale: 2 }
      t.boolean :satisfied?, { null: false, default: false }

      t.timestamps null: false
    end
  end
end
