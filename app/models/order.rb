class Order < ActiveRecord::Base
  attr_accessible :customer_id, :storekeeper_id

  belongs_to :storekeeper
  has_many :order_its
end
