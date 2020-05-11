class ChangeUserTokenTableName < ActiveRecord::Migration[5.2]
  def self.up
    rename_table :user_tokens, :login_sessions
  end

  def self.down
    rename_table :login_sessions, :user_tokens
  end
end
