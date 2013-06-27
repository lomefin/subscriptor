require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Same Plan name for same product go up a version" do
    first_template = Plan.create(product: products(:familink),name: "Basic")
    second_template = Plan.create(product: products(:familink),name: "Basic")
    Rails::logger.debug first_template.inspect
    Rails::logger.debug second_template.inspect
    assert_equal first_template.version + 1,second_template.version 
  end

  test "Subscribe customer to plan" do
    plan = Plan.create(product: products(:familink), name: "Default")
    client = customers(:john)
    plan.subscribe(client)
    assert_equal plan.subscriptions.count, 1
  end

end
