class Customer < ActiveRecord::Base
  has_many :subscriptions
  belongs_to :product

  def active_subscriptions
    subscriptions.active
  end
  def expired_subscriptions
    subscriptions.reject{|x| x.is_active?}
  end
end
