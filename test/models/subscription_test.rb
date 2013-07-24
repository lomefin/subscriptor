require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Charge Customer from subscription" do
    john = customers(:john)
    familink = products(:familink)
    familink.connector = Connectors::FamilinkConnector
    familink.save
    plan = Plan.create(product: familink, name: "Default")
    

    plan.subscribe(john)

    subscription = plan.subscribe(john)
    voucher_count = subscription.vouchers.count

    subscription.generate_voucher

    new_voucher_count = subscription.vouchers.count

    assert_not_equal voucher_count, new_voucher_count
    assert_equal new_voucher_count, voucher_count + 1
    

  end
  
end
