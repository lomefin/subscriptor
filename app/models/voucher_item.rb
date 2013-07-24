class VoucherItem < ActiveRecord::Base
  belongs_to :voucher
  
  def amount
    @amount_pesos
  end
  def amount=(amount)
    @amount_pesos = amount
  end
end
