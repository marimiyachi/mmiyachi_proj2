class AddSotrekeeperIdToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :storekeeper_id, :integer
  end
end
