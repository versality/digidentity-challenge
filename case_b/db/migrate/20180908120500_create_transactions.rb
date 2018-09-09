class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 12, scale: 2, default: 0
      t.integer :operation_type
      t.integer :account_sender_id, foreign_key: true
      t.integer :account_recipient_id, foreign_key: true, required: true
      t.index :account_sender_id
      t.index :account_recipient_id
      t.timestamps
    end
  end
end
