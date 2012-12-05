class Item < ActiveRecord::Base
  attr_accessible :description, :name, :price, :quantity

  belongs_to :store

  # decrement the quantity
  def decrement_quantity
    q = self.quantity.to_i - 1
    self.update_attributes(quantity: q)
  end

  # increment the quantity
  def increment_quantity
    q = self.quantity.to_i + 1
    self.update_attributes(quantity: q)
  end

end
