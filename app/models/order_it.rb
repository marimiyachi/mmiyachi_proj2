class OrderIt < ActiveRecord::Base
  attr_accessible :item_number, :order_id

  belongs_to :order
end
