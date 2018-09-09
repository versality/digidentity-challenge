class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.decimal :balance, precision: 12, scale: 2, default: 0
      t.references :user
      t.timestamps
    end
  end
end
