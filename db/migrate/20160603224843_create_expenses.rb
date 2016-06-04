class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :event_id, { null: false }
      t.integer :spender_id, { null: false }
      t.string :description, { null: false }
      t.float :amount, { null: false }
      t.string :location

      t.timestamps null: false
    end
  end
end
