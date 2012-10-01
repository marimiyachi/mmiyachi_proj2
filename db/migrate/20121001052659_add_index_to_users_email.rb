class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :storekeepers, :email, unique: true
  end
end
