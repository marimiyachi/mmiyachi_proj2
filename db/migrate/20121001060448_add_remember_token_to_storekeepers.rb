class AddRememberTokenToStorekeepers < ActiveRecord::Migration
  def change
    add_column :storekeepers, :remember_token, :string
    add_index :storekeepers, :remember_token
  end
end
