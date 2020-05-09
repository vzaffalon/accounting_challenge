class CreateAccountTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :account_transactions do |t|
      t.integer :amount
      t.bigint :account_id, index: true

      t.datetime :deleted_at

      t.timestamps
    end
  end
end
