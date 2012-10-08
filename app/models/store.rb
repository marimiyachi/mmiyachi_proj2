class Store < ActiveRecord::Base
  attr_accessible :description, :name

  validates :storekeeper_id, presence: true

  belongs_to :storekeeper
  has_many :items
end
