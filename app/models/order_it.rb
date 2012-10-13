class OrderIt < ActiveRecord::Base
  attr_accessible :item_number, :order_id

  belongs_to :order

  # getter for item name
  def item_name
    return Item.find_by_id(self.item_number).name
  end
end
