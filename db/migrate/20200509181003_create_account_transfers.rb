class CreateAccountTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :account_transfers do |t|
      t.integer :amount
      t.bigint :source_account_id, index: true
      t.bigint :destination_account_id, index: true

      t.datetime :deleted_at

      t.timestamps
    end
  end
end
