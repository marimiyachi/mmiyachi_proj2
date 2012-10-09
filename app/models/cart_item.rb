class CartItem < ActiveRecord::Base
  attr_accessible :item_number, :store_number

  belongs_to :cart
end
