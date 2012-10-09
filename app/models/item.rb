class Item < ActiveRecord::Base
  attr_accessible :description, :name, :price, :quantity

  belongs_to :store
end
