class OrderIt < ActiveRecord::Base
  attr_accessible :item_number, :order_id, :name, :price, :status, :store_id

  belongs_to :order

  # getter for store name
  def store_name
    if self.store_id
      return Store.find_by_id(self.store_id).name
    end
  end
end
