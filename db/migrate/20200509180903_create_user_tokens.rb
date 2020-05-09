class CreateUserTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tokens do |t|
      t.string :token
      t.datetime :expiry_at
      t.bigint :user_id, index: true

      t.datetime :deleted_at

      t.timestamps
    end
  end
end
