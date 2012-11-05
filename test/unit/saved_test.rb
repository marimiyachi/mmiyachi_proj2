require 'test_helper'

class SavedTest < ActiveSupport::TestCase
  fixtures :items, :saveds, :stores, :storekeepers

  # test getters for item information
  def test_name
    item = items(:one)
    storekeeper = storekeepers(:one)
    saved = storekeeper.saveds.create(item_id: item.id)
    assert_equal item.name, saved.item_name
  end

  def test_price
    item = items(:one)
    storekeeper = storekeepers(:one)
    saved = storekeeper.saveds.create(item_id: item.id)
    assert_equal item.price, saved.item_price
  end

  def test_store_name
    store = stores(:one)
    item = store.items.create()
    storekeeper = storekeepers(:one)
    saved = storekeeper.saveds.create(item_id: item.id)
    assert_equal store.name, saved.store_name
  end

  def test_quantity
    item = items(:one)
    storekeeper = storekeepers(:one)
    saved = storekeeper.saveds.create(item_id: item.id)
    assert_equal item.quantity, saved.quantity
  end
end
