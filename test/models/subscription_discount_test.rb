require 'test_helper'

class SubscriptionDiscountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Discount amount works properly" do
    
    voucher = Voucher.create
    (1..10).each {|x| voucher.add_item(VoucherItem.create(amount: 200))}
    total = voucher.total
    subscription_discount = subscription_discounts(:sd1)

    subscription_discount.apply_to(voucher)
    new_total = voucher.total

    assert_equal 1000,new_total
  end
end
