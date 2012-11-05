require 'test_helper'

class CartItemTest < ActiveSupport::TestCase

  fixtures :items, :storekeepers, :stores, :carts

  # test creation of cart item
  def test_create
    storekeeper = storekeepers(:one)
    cart_item = items(:one)
    cart = carts(:one)
    item_copy = cart.cart_items.create(:item_number => cart_item.id)
    assert_equal cart_item.id, item_copy.item_number
  end

  # test getter for store name
  def test_store_name
    storekeeper = storekeepers(:one)
    store = stores(:one)
    new_store = storekeeper.stores.create(name: store.name)
    item = new_store.items.create(name: "Test")
    cart = carts(:one)
    cart_item = cart.cart_items.create(item_number: item.id, store_number: new_store.id)
    assert_equal new_store.name, cart_item.store_name
  end

end
