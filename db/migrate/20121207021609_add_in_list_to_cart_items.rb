class AddInListToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :in_list, :boolean
  end
end
