class SubscriptionDiscount < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :discount

  def self.remaining
    where('applied_on is NULL')
  end

  def apply_to(voucher)
    total_value = voucher.total

    calculated_discount = discount.value 
    calculated_discount = total_value * discount.value/100 if discount.unit == :percentage

    effective_discount = [total_value,calculated_discount].min
    
    voucher.add_item VoucherItem.create(amount: -effective_discount, description: "Default Discount")
    
    applied_on = DateTime.now
    save
  end
end
