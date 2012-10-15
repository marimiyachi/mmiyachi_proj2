class Order < ActiveRecord::Base
  attr_accessible :customer_id, :storekeeper_id

  belongs_to :storekeeper
  has_many :order_its
  
  # getter for order's customer name
  def customer_name
    return Storekeeper.find_by_id(self.storekeeper_id).name
  end

  # getter for order's customer email
  def customer_email
    return Storekeeper.find_by_id(self.storekeeper_id).email
  end

  # requires: storekeeper
  # returns array of items belonging to storekeeper
  def contains_items_from(storekeeper)
    self.order_its.each do |item|
      if Item.find_by_id(item.item_number)
        if Item.find_by_id(item.item_number).store_id == storekeeper.stores.first.id
          return true
        end
      end
    end
    return false
  end

end
