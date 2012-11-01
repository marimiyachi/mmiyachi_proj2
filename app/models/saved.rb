class Saved < ActiveRecord::Base
  attr_accessible :item_id, :storekeeper_id
  belongs_to :storekeeper

  # getter for item name
  def item_name
    return Item.find_by_id(self.item_id).name
  end

  # getter for item price
  def item_price
    return Item.find_by_id(self.item_id).price
  end

  # getter for store name
  def store_name
    return Store.find_by_id(Item.find_by_id(self.item_id).store_id).name
  end
  
  # getter for item quantity
  def quantity
    return Item.find_by_id(self.item_id).quantity
  end
end
