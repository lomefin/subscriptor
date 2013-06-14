require 'test_helper'

class DiscountsControllerTest < ActionController::TestCase
  setup do
    @discount = discounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discounts)
  end

  test "should create discount" do
    assert_difference('Discount.count') do
      post :create, discount: { applied_to: @discount.applied_to, plan_id: @discount.plan_id, unit: @discount.unit }
    end

    assert_response 201
  end

  test "should show discount" do
    get :show, id: @discount
    assert_response :success
  end

  test "should update discount" do
    put :update, id: @discount, discount: { applied_to: @discount.applied_to, plan_id: @discount.plan_id, unit: @discount.unit }
    assert_response 204
  end

  test "should destroy discount" do
    assert_difference('Discount.count', -1) do
      delete :destroy, id: @discount
    end

    assert_response 204
  end
end
