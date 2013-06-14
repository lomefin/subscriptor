require 'test_helper'

class PlansControllerTest < ActionController::TestCase
  setup do
    @plan = plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plans)
  end

  test "should create plan" do
    assert_difference('Plan.count') do
      post :create, plan: { name: @plan.name, product_id: @plan.product_id }
    end

    assert_response 201
  end

  test "should show plan" do
    get :show, id: @plan
    assert_response :success
  end

  test "should update plan" do
    put :update, id: @plan, plan: { name: @plan.name, product_id: @plan.product_id }
    assert_response 204
  end

  test "should destroy plan" do
    assert_difference('Plan.count', -1) do
      delete :destroy, id: @plan
    end

    assert_response 204
  end
end
