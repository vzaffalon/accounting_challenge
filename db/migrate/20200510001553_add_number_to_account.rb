class AddNumberToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :number, :string
    add_index :accounts, :number, unique: true
  end
end
