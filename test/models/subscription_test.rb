require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Charge Customer from subscription" do
    john = customers(:john)

    previous_charge_count = john.charges.count
    plan = Plan.create(product: products(:familink),name: "Basic")
    plan.subscribe(john)
    plan.calculate_charges_to_customers

    assert_not_equal john.charges.count , previous_charge_count

  end
  
end
