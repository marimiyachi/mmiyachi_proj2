require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  fixtures :orders, :storekeepers, :items

  # test order methods for retriving customer information
  def test_customer_info
    order = orders(:one)
    order.update_attributes(customer_id: storekeepers(:one).id)
    assert_equal order.customer_name, storekeepers(:one).name
    assert_equal order.customer_email, storekeepers(:one).email
  end

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

end
