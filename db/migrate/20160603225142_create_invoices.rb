class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :event_id, { null: false }
      t.integer :user_id, { null: false }
      t.string :invoice_type, { null: false }
      t.float :amount, { null: false }
      t.boolean :satisfied?, { null: false, default: false }

      t.timestamps null: false
    end
  end
end
