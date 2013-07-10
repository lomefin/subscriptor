require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  

  def subscribe_user_to_plan
    john = customers(:john)
    plan = Plan.create(product: products(:familink), name: "Default")
    plan.subscribe(john)
    plan
  end

  test "Same Plan name for same product go up a version" do
    first_template = Plan.create(product: products(:familink),name: "Basic")
    second_template = Plan.create(product: products(:familink),name: "Basic")

    assert_equal first_template.version + 1,second_template.version 
  end

  test "Get subscription when subscribing to plan" do
    john = customers(:john)
    plan = Plan.create(product: products(:familink), name: "Default")
    

    assert_kind_of Subscription, plan.subscribe(john)
  end

  test "Subscribe customer to plan" do
    plan = subscribe_user_to_plan
    assert_equal plan.subscriptions.count, 1
  end

  test "New Subscription transfers discounts" do
    plan = plans(:familink_pro)
    john = customers(:john)

    plan.subscribe(john)

    first_subscription = john.subscriptions.first
    assert_equal first_subscription.plan, plan
  end

  test "Subscribe and unsubscribe customer to several plans" do
    john    = customers(:john)
    first   = Plan.create(product: products(:familink),name: "Basic")
    second  = Plan.create(product: products(:familink),name: "Medium")    

    first.subscribe(john)
    second.subscribe(john)

    assert_equal john.subscriptions.count, 2
    assert_equal john.active_subscriptions.count, 2

    john.active_subscriptions.first.unsubscribe

    assert_equal john.subscriptions.count, 2
    assert_equal john.active_subscriptions.count, 1    
  end

  test "Unsubscribe customer from plan" do
    plan = subscribe_user_to_plan
    previous_subscription_count = plan.subscriptions.active.count 

    john = customers(:john)
    john.active_subscriptions.first.unsubscribe
    assert_equal plan.subscriptions.active.count, previous_subscription_count - 1
  end

  test "Throw error when trying to subscribe customer to a plan from a different Product" do
    snapchild = products(:snapchild)
    client = Customer.create(product: snapchild, provider_id: 1)

    familink = products(:familink)
    familink_plan   = Plan.create(product: products(:familink),name: "Basic")

    assert_raise Plan::PlanNotAvailableForCustomerProductException do 
      familink_plan.subscribe(client)
    end

  end

  

end
