require 'test_helper'

class StorekeeperTest < ActiveSupport::TestCase

  fixtures :storekeepers

  # Test ability to create and destroy a Storekeeper object
  def test_new_storekeeper
    storekeeper = Storekeeper.create(name: storekeepers(:one).name,
                                  email: storekeepers(:one).email,
                                  password: "Test12",
                                  password_confirmation: "Test12")


    storekeeper_copy = Storekeeper.find_by_name(storekeeper.name)
    assert_equal storekeeper.name, storekeeper_copy.name

    storekeeper.name = "Test"
    assert storekeeper.destroy
  end

  # test store_exists function for Storekeeper model
  def test_store_exists
    storekeeper = storekeepers(:one)
    storekeeper.stores.create(name: "Test", description: "Test")
    assert storekeeper.store_exists
  end
  
end
