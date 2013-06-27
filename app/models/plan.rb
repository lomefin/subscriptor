class Plan < ActiveRecord::Base
  belongs_to :product
  has_many :subscriptions
  has_many :customers, through: :subscriptions
  before_save :check_version

  def subscribe(customer,options = {})
    Subscription.create(plan: self,customer: customer, valid_until: options[:valid_until], name: options[:name])
  end
  def valid_subscriptions
    subscriptions.reject{|x| not x.is_active?}
  end
  def unsubscribe_all
    subscriptions.unsubscribe
  end

  def check_version
    existing_plan = Plan.where(product: product,name: name).order('version DESC').first
    return if existing_plan.nil?
    latest_version_number = existing_plan.version
    self.version = latest_version_number + 1
    self
  end
end
