class Order < ActiveRecord::Base
  attr_accessible :customer_id, :storekeeper_id, :status

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
  # returns boolean if order contains items belonging to storekeeper
  def contains_items_from(storekeeper)
    if storekeeper.stores.any?
      self.order_its.each do |item|
        if Item.find_by_id(item.item_number)
          if Item.find_by_id(item.item_number).store_id == storekeeper.stores.first.id
            return true
          end
        end
      end
    end
    return false
  end

  # requires: storekeeper
  # alters status of only items belonging to storekeeper
  def fufill(storekeeper)
    self.order_its.each do |item|
      if item.store_id == storekeeper.stores.first.id
        item.update_attributes(status: "Fufilled")
      end
    end
  end

  # Checks status of all items in order
  # Alters order status only if all items in order are "FUFILLED"
  # Return order status
  def check_status
    self.update_attributes(status: "Fufilled")
    self.order_its.each do |item|
      if item.status == "Pending"
        self.update_attributes(status: "Pending")
      end
    end
    return self.status
  end

  # Returns boolean true if order items belonging to storekeeper are fufilled
  def check_fufilled
    self.order_its.each do |item|
      if storekeeper.stores.any?
        if item.store_id == storekeeper.stores.first.id
          if item.status == "Pending"
            return false
          end
        end
      end
    end
    return true
  end
end
