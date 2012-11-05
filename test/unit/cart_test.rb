require 'test_helper'

class CartTest < ActiveSupport::TestCase

  fixtures :carts, :items, :storekeepers, :saveds

  # test the cart total function
  def test_total
    cart = carts(:one)
    original = items(:one)
    item = cart.cart_items.build()
    item.update_attributes(item_number: original.id,
                          store_number: 1)

    t = cart.total(cart.cart_items)
    assert_equal t, original.price
  end

  # test the final_checkout function
  def test_checkout
    cart = carts(:one)
    original = items(:one)
    item = cart.cart_items.build()
    item.update_attributes(item_number: original.id,
                          store_number: 1)
    order = cart.final_checkout(storekeepers(:one))
    assert_equal 0, cart.cart_items.count
  end

  # test the add_item function
  def test_add_item
    storekeeper = storekeepers(:one)
    new_cart = storekeeper.carts.create()
    item = items(:one)
    new_cart.add_item(item)
    assert_equal item.name, new_cart.cart_items.first.item_name
  end
end
