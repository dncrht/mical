class DropClearanceColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :confirmation_token, :string
    remove_column :users, :remember_token, :string
    rename_column :users, :encrypted_password, :password_digest
  end
end
