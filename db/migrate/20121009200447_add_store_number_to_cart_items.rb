class AddStoreNumberToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :store_number, :integer
  end
end
