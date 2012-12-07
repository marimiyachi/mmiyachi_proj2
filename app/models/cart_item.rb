class CartItem < ActiveRecord::Base
  attr_accessible :item_number, :store_number, :storekeeper_id, :in_list

  belongs_to :storekeeper

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

  # getter for item's quantity
  def quantity
    return Item.find_by_id(self.item_number).quantity
  end

  # change boolean in_list to true
  def save_list
    self.update_attributes(:in_list => true)
  end

  # change boolean in_list to false
  def unsave_list
    self.update_attributes(:in_list => false)
  end


end
