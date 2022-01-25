class UserAddAttributes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :email, false
    add_index :users, :email, :unique => true
    add_column :users, :reset_password_token, :string
    add_index :users, :reset_password_token, :unique => true
    add_column :users, :refresh_token, :string
  end
end
