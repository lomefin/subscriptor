class Customer < ActiveRecord::Base
  has_many :subscriptions

  def valid_subscriptions
    subscriptions.reject{|x| not x.is_active?}
  end
  def expired_subscriptions
    subscriptions.reject{|x| x.is_active?}
  end
end
