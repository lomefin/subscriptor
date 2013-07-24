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

    voucher = subscription.generate_voucher

    new_voucher_count = subscription.vouchers.count

    assert_not_equal voucher_count, new_voucher_count
    assert_equal new_voucher_count, voucher_count + 1
    
    assert_equal voucher.due_date, Date.today + 5.days
  end
  

  test "Is valid works correctly" do

    john = customers(:john)
    familink = products(:familink)
    familink.connector = Connectors::FamilinkConnector
    familink.save
    plan = Plan.create(product: familink, name: "Default")
    

    plan.subscribe(john)

    subscription = plan.subscribe(john)
    voucher_count = subscription.vouchers.count

    assert_equal true, subscription.is_valid?

    voucher = subscription.generate_voucher
    assert_equal true, subscription.is_valid?

    voucher.due_date = Date.today 
    assert_equal true, subscription.is_valid?

    voucher.due_date = 1.days.ago
    assert_equal false, subscription.is_valid?

    voucher.fulfilled = Date.today
    assert_equal true, subscription.is_valid?

  end

  test "First payment is a month later" do
    john = customers(:john)
    mary = customers(:mary)
    familink = products(:familink)
    familink.connector = Connectors::FamilinkConnector
    familink.save
    plan = Plan.create(product: familink, name: "Default")

    js = plan.subscribe(john)
    Rails.logger.info js.inspect
    assert_equal Date.today + 1.month, js.next_payment 
  end

  test "Due Subscriptions work correctly" do
    john = customers(:john)
    mary = customers(:mary)
    familink = products(:familink)
    familink.connector = Connectors::FamilinkConnector
    familink.save
    plan = Plan.create(product: familink, name: "Default")

    js = plan.subscribe(john)
    ms = plan.subscribe(mary)

    assert_equal false, js.is_due?
    js.next_payment = 2.weeks.ago
    js.save

    assert_equal true, js.is_due?
    assert_equal 1,Subscription.due.count

    ms.next_payment = 2.weeks.ago
    ms.save

    assert_equal 2, Subscription.due.count

    ms.unsubscribed_at = 1.week.ago
    ms.save
    assert_equal 1, Subscription.due.count
  end
end
