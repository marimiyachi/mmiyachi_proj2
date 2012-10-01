require 'test_helper'

class StorekeepersControllerTest < ActionController::TestCase
  setup do
    @storekeeper = storekeepers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:storekeepers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create storekeeper" do
    assert_difference('Storekeeper.count') do
      post :create, storekeeper: { email: @storekeeper.email, name: @storekeeper.name, password_digest: @storekeeper.password_digest }
    end

    assert_redirected_to storekeeper_path(assigns(:storekeeper))
  end

  test "should show storekeeper" do
    get :show, id: @storekeeper
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @storekeeper
    assert_response :success
  end

  test "should update storekeeper" do
    put :update, id: @storekeeper, storekeeper: { email: @storekeeper.email, name: @storekeeper.name, password_digest: @storekeeper.password_digest }
    assert_redirected_to storekeeper_path(assigns(:storekeeper))
  end

  test "should destroy storekeeper" do
    assert_difference('Storekeeper.count', -1) do
      delete :destroy, id: @storekeeper
    end

    assert_redirected_to storekeepers_path
  end
end
