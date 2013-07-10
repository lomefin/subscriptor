class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :customer 

  has_many :item_charges
  has_many :subscription_discounts
  class UnableToGenerateChargeException < Exception
  end
  def unsubscribe
    self.unsubscribed_at = DateTime.now
    self.save
  end

  def is_due?(due_date=DateTime.now)
    next_payment < due_date
  end

  def get_usage
    plan.product.get_usage(customer.provider_id)
  end

  def generate_voucher
    voucher = Voucher.create()
    begin
      charges = plan.calculate_charges(get_usage)
      raise UnableToGenerateChargeException.new("Nil charges") if charges.nil?
      calculate_next_due_date
      save
    rescue
      raise UnableToGenerateChargeException.new if charges.nil?
    end
    
    charges.each {|c| voucher.add_item(c) }

    begin 
      discount = subscription_discounts.remaining.first
      discount.apply_to(voucher)
    rescue
      raise UnableToApplyDiscountException.new
    end
    voucher
  end

  def next_discount
    begin
      discount = 
      discount.applied_on = DateTime.now
      discount.save
      return discount
    rescue
      return nil
    end

  end
  def calculate_next_due_date
    more_time = 1.month
    more_time = 1.week if plan.periodicity == :weekly
    
    next_payment + more_time

  end

  def is_active?
    ((valid_until.nil? or valid_until > DateTime.now) and unsubscribed_at.nil?)
  end

  def self.due(due_date=DateTime.now)
    where(['next_payment < ?',due_date])
  end

  def self.active
    where(['(valid_until is NULL OR valid_until > ?) AND unsubscribed_at IS NULL',DateTime.now])
  end
end
