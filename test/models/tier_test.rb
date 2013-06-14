require 'test_helper'

class TierTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Calculate costs and return remainder" do
    
    assert_equal [500,0], Tier.new(price_per_unit:100,max_units: 10).cost_for(5)

    assert_equal [1000,0], Tier.new(price_per_unit:100,max_units: 10).cost_for(10)

    assert_equal [1000,5], Tier.new(price_per_unit:100,max_units: 10).cost_for(15)
  end
end
