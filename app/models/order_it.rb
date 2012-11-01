class OrderIt < ActiveRecord::Base
  attr_accessible :item_number, :order_id, :name, :price

  belongs_to :order
end
