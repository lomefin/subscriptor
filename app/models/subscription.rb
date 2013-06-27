class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :customer 

  def unsubscribe
    self.unsubscribed_at = DateTime.now
    self.save
  end

  def is_active?
    ((valid_until.nil? or valid_until > DateTime.now) and unsubscribed_at.nil?)
  end
end
