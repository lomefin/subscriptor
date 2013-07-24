class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :customer 

  has_many :item_charges
  has_many :subscription_discounts
  has_many :vouchers

  after_create :calculate_next_due_date

  class UnableToGenerateChargeException < Exception
  end
  class UnableToApplyDiscountException < Exception
  end


  def unsubscribe
    self.unsubscribed_at = DateTime.now
    self.save
  end

  def get_usage
    plan.product.request_usage_for_client(customer.provider_id)
  end

  def generate_voucher
    voucher = Voucher.create()
    charges = []
    begin
      charges << plan.calculate_charge(get_usage)
      raise UnableToGenerateChargeException.new("Nil charges") if charges.nil?
      calculate_next_due_date
      save
    rescue => e
      Rails.logger.warn e.inspect
      e.backtrace.each {|x| Rails.logger.warn x}
      raise UnableToGenerateChargeException.new if charges.nil?
    end
    
    charges.each {|c| voucher.add_item(c) }

    begin 
      discount = subscription_discounts.remaining.first
      discount.apply_to(voucher) unless discount.nil?
    rescue
      raise UnableToApplyDiscountException.new
    end
    voucher.due_date = Date.today + plan.grace_period.days
    vouchers << voucher
    voucher
  end

  def calculate_next_due_date
    base_date = self.next_payment
    base_date = Date.today if self.next_payment.nil?

    more_time = 1.month
    more_time = 1.week if plan.periodicity == :weekly

    self.next_payment = base_date + more_time
    save
  end

  def is_due?(due_date=DateTime.now)
    next_payment < due_date
  end

  def is_valid?
    (vouchers.count == 0 or vouchers.last.due_date >= Date.today or vouchers.last.fulfilled?)
  end

  def is_active?
    ((valid_until.nil? or valid_until > DateTime.now) and unsubscribed_at.nil?)
  end

  def self.active
    where(['(valid_until is NULL OR valid_until > ?) AND unsubscribed_at IS NULL',DateTime.now])
  end

  def self.due(due_date=Date.today)
    active.where(['next_payment < ?',due_date])
  end

end
