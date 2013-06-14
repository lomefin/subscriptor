require 'test_helper'

class ItemChargesControllerTest < ActionController::TestCase
  setup do
    @item_charge = item_charges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_charges)
  end

  test "should create item_charge" do
    assert_difference('ItemCharge.count') do
      post :create, item_charge: { description: @item_charge.description, due: @item_charge.due, plan_id: @item_charge.plan_id }
    end

    assert_response 201
  end

  test "should show item_charge" do
    get :show, id: @item_charge
    assert_response :success
  end

  test "should update item_charge" do
    put :update, id: @item_charge, item_charge: { description: @item_charge.description, due: @item_charge.due, plan_id: @item_charge.plan_id }
    assert_response 204
  end

  test "should destroy item_charge" do
    assert_difference('ItemCharge.count', -1) do
      delete :destroy, id: @item_charge
    end

    assert_response 204
  end
end
