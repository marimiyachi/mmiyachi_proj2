class OrderIt < ActiveRecord::Base
  attr_accessible :item_number, :order_id, :name, :price, :status, :store_id

  belongs_to :order
end
