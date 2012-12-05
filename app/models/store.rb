class Store < ActiveRecord::Base
  attr_accessible :description, :name

  validates :storekeeper_id, presence: true

  belongs_to :storekeeper
  has_many :items

  # returns a boolean true if a store has
  # any item with quantity > 0
  def items_available
    if self.items.any?
      self.items.each do |item|
        if item.quantity > 0
          return true
        end
      end
      return false
    else
      return false
    end
  end
end
