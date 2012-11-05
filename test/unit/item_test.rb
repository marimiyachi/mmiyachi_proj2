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

  # test decrementing item quantity
  def test_decrement
    item = items(:one)
    new_quantity = item.quantity.to_i - 1 
    item.update_quantity
    assert_equal new_quantity, item.quantity
  end

  # test incrementing item quantity
  def test_increment
    item = items(:one)
    new_quantity = item.quantity.to_i + 1
    item.increment_quantity
    assert_equal new_quantity, item.quantity
  end

end
