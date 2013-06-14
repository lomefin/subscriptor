require 'test_helper'

class TiersControllerTest < ActionController::TestCase
  setup do
    @tier = tiers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tiers)
  end

  test "should create tier" do
    assert_difference('Tier.count') do
      post :create, tier: { charge_id: @tier.charge_id, max_units: @tier.max_units, name: @tier.name }
    end

    assert_response 201
  end

  test "should show tier" do
    get :show, id: @tier
    assert_response :success
  end

  test "should update tier" do
    put :update, id: @tier, tier: { charge_id: @tier.charge_id, max_units: @tier.max_units, name: @tier.name }
    assert_response 204
  end

  test "should destroy tier" do
    assert_difference('Tier.count', -1) do
      delete :destroy, id: @tier
    end

    assert_response 204
  end
end
