class Voucher < ActiveRecord::Base
  belongs_to :subscription
  has_many :voucher_items

  def total
    voucher_items.each {|x| Rails.logger.info "Total sum" + x.inspect}
    voucher_items.collect {|x| x.amount}.sum
  end
  def add_item(voucher_item)
    raise if voucher_item.amount.nil?
    voucher_items << voucher_item
    save
    
  end
end
