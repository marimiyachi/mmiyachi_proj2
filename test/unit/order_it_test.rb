require 'test_helper'

class OrderItTest < ActiveSupport::TestCase
  fixtures :stores, :orders, :order_its

  # test store name getter
  def test_store_name
    store = stores(:one)
    order_it = order_its(:one)
    order_it.update_attributes(store_id: store.id)
    assert_equal(store.id, order_it.store_id)
  end
end
