class VoucherItem < ActiveRecord::Base
  belongs_to :voucher
  
  def amount
    Rails::logger.debug "Getting amount (pesos): " + amount_pesos.to_s
    @amount_pesos
  end
  def amount=(amount)
    Rails::logger.debug "Amount: " + amount.to_s
    @amount_pesos = amount
    Rails::logger.debug "Setting amount (pesos): " + amount_pesos.to_s
  end
end
