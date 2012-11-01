require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  fixtures :orders, :storekeepers, :items
  # test the contains_items_from method
  def test_contains_items
    order = orders(:one)
    original = storekeepers(:one).stores.create(name: "test",
                                                description: "test")
        .items.create(name: "Test",
                      price: 12,
                      quantity: 3,
                      description: "test")
    item = order.order_its.new()
    item.update_attributes(item_number: original.id)
    assert order.contains_items_from(storekeepers(:one))
  end

  # test the fufill method
  def test_fufill
    order = orders(:one)
    original = storekeepers(:one).stores.create(name: "test", description: "test")
    oitem = original.items.create(name: "Test", price: 2, quantity: 2)
    item = order.order_its.create(store_id: original.id, status: "Pending")
    order.fufill(storekeepers(:one))
    assert_equal "Fufilled", item.status
  end
end
