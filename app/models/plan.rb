class Plan < ActiveRecord::Base

  class PlanNotAvailableForCustomerProductException < Exception
  end
  belongs_to :product
  has_many :subscriptions
  has_many :customers, through: :subscriptions
  has_many :discounts
  has_many :tiers
  before_save :check_version

  def subscribe(customer,options = {})
    raise PlanNotAvailableForCustomerProductException.new() if customer.product_id != self.product_id
    subscription = Subscription.create(plan: self,customer: customer, valid_until: options[:valid_until], name: options[:name])
    add_discounts_to_subscription(subscription)
    subscription
  end
  def add_discounts_to_subscription(subscription)
    discounts.order(:position).each {|discount| SubscriptionDiscount.create(discount: discount, subscription: subscription) }
  end
  def valid_subscriptions
    subscriptions.reject{|x| not x.is_active?}
  end
  def unsubscribe_all
    subscriptions.unsubscribe
  end
  def calculate_charge(usage)
    #Assuming that usage is one number and that we have only one tier class
    my_tiers = tiers.order(:max_units)
    tier_charges = []
    total_cost = 0
    my_tiers.each do |tier|
      tier_cost = tier.charge_for(units)
      (tier_cost, units) = tier_cost
      tier_charges << tier_cost
      total_cost = total_cost + tier_cost
    end

    VoucherItem.create(description: "Default Usage", amount: total_cost)

  end
  def check_version
    existing_plan = Plan.where(product: product,name: name).order('version DESC').first
    return if existing_plan.nil?
    latest_version_number = existing_plan.version
    self.version = latest_version_number + 1
    self
  end
end
