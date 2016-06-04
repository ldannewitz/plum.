class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, { null: false }
      t.datetime :start, { null: false }
      t.datetime :end, { null: false }
      t.boolean :settled?, { null: false, default: false }
      t.integer :group_id, { null: false }
      t.float :total, { null: false, default: 0.00 }

      t.timestamps null: false
    end
  end
end
