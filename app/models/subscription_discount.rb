class SubscriptionDiscount < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :discount

  def self.remaining
    where('applied_on is NULL')
  end

  def apply_to(voucher)
    total_value = voucher.total
    Rails.logger.info "Discount: " + discount.inspect
    value = discount.value  #Its returning nil
    applied_on = DateTime.now
    Rails.logger.info [total_value,value].inspect
    effective_discount = [total_value,value].min
    Rails.logger.info "effective_discount: " +effective_discount.to_s 
    voucher.add_item VoucherItem.create(amount: -effective_discount, description: "Default Discount")
    save
  end
end
