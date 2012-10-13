class Order < ActiveRecord::Base
  attr_accessible :customer_id, :storekeeper_id

  belongs_to :storekeeper
  has_many :order_its
  
  # getter for order's customer name
  def customer_name
    return Storekeeper.find_by_id(self.customer_id).name
  end

  # getter for order's customer email
  def customer_email
    return Storekeeper.find_by_id(self.customer_id).email
  end
end
