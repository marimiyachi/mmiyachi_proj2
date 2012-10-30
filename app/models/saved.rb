class Saved < ActiveRecord::Base
  attr_accessible :item_id, :storekeeper_id
  belongs_to :storekeeper

  def item_name
    return Item.find_by_id(self.item_id).name
  end

  def item_price
    return Item.find_by_id(self.item_id).price
  end

  def store_name
    return Store.find_by_id(Item.find_by_id(self.item_id).store_id).name
  end
  
end
