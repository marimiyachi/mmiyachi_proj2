class CartItem < ActiveRecord::Base
  attr_accessible :item_number, :store_number

  belongs_to :cart

  # getter for item name
  def item_name
    return Item.find_by_id(self.item_number).name
  end

  # getter for item price
  def item_price
    return Item.find_by_id(self.item_number).price
  end

  # getter for item's store name
  def store_name
    return Store.find_by_id(self.store_number).name
  end
end
