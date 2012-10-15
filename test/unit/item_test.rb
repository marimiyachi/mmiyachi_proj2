require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  fixtures :items, :storekeepers

  # test basket and quantity updates
  def test_basket
    storekeeper = storekeepers(:one)
    store = storekeeper.stores.create(name: "Store",
                              description: "Blah")
    cart = storekeeper.carts.create()
    item = store.items.create(name: "test",
                              price: 12.5,
                              quantity: 3,
                              description: "blah")
    item.update_quantity
    cart.add_item(item)
    assert_equal item.quantity, 2
    assert_equal cart.cart_items.first.item_number, item.id
  end

end
