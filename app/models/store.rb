class Store < ActiveRecord::Base
  attr_accessible :description, :name

  belongs_to :storekeeper
  has_many :items
end
