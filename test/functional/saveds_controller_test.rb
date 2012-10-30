require 'test_helper'

class SavedsControllerTest < ActionController::TestCase
  setup do
    @saved = saveds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:saveds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saved" do
    assert_difference('Saved.count') do
      post :create, saved: { item_id: @saved.item_id, storekeeper_id: @saved.storekeeper_id }
    end

    assert_redirected_to saved_path(assigns(:saved))
  end

  test "should show saved" do
    get :show, id: @saved
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saved
    assert_response :success
  end

  test "should update saved" do
    put :update, id: @saved, saved: { item_id: @saved.item_id, storekeeper_id: @saved.storekeeper_id }
    assert_redirected_to saved_path(assigns(:saved))
  end

  test "should destroy saved" do
    assert_difference('Saved.count', -1) do
      delete :destroy, id: @saved
    end

    assert_redirected_to saveds_path
  end
end
