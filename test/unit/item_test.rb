require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  fixtures :items, :storekeepers

  # test basket and quantity updates
  def test_basket
    storekeeper = storekeepers(:one)
    store = storekeeper.stores.create(name: "Store",
                              description: "Blah")
    cart = storekeeper.carts.new
    item = store.items.create(name: "test",
                              price: 12.5,
                              quantity: 3,
                              description: "blah")
    assert_equal item.quantity, 3
  end

end
