class Cart < ActiveRecord::Base
  attr_accessible :storekeeper_id

  belongs_to :storekeeper
  has_many :cart_items

  # requires: array of cart_items
  # returns: total of value of cart_items
  def total(cart_items)
    total = 0
    cart_items.each do |item|
      if Item.find_by_id(item.item_number)
        item_price = Item.find_by_id(item.item_number).price
        total = total + item_price
      end
    end
    return total
  end
end
