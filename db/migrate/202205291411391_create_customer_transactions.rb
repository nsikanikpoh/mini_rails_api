class CreateCustomerTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_transactions do |t|
      t.string :identifier, null: false
      t.integer :customer_id, null: false, limit: 8
      t.inet    :request_ip, null: false
      t.decimal :in_amount, null: false, :precision => 30, scale: 2, default: 0.00
      t.string :in_currency, null: false
      t.decimal :out_amount, null: false, :precision => 30, scale: 2, default: 0.00
      t.string :out_currency, null: false
      t.datetime :transaction_date, null: false
      t.timestamps
    end
    add_index :customer_transactions, :identifier, unique: true
  end
end
