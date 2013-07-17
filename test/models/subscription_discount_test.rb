require 'test_helper'

class SubscriptionDiscountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Discount amount works properly" do
    
    voucher = Voucher.create
    (1..10).each {|x| voucher.add_item(VoucherItem.create(amount: 200))}
    total = voucher.total
    assert_equal total, 2000
    d = Discount.create(value: 1000)
    subscription_discount = SubscriptionDiscount.create(discount: d)
    subscription_discount.apply_to(voucher)

    assert_equal 1000,voucher.total
  end

  test "Discount percentage works properly" do
    voucher = Voucher.create
    (1..10).each {|x| voucher.add_item(VoucherItem.create(amount: 200))}
    total = voucher.total
    assert_equal total, 2000
    d = Discount.create(value: 50, unit: :percentage)
    subscription_discount = SubscriptionDiscount.create(discount: d)
    subscription_discount.apply_to(voucher)

    assert_equal 1000,voucher.total

    voucher = Voucher.create
    (1..10).each {|x| voucher.add_item(VoucherItem.create(amount: 250))} # $2.500
    total = voucher.total
    assert_equal total, 2500
    d = Discount.create(value: 32, unit: :percentage)
    subscription_discount = SubscriptionDiscount.create(discount: d)
    subscription_discount.apply_to(voucher)

    assert_equal 1700,voucher.total

    voucher = Voucher.create
    (1..10).each {|x| voucher.add_item(VoucherItem.create(amount: 250))} # $2.500
    total = voucher.total
    assert_equal total, 2500
    d = Discount.create(value: 32.26, unit: :percentage)
    subscription_discount = SubscriptionDiscount.create(discount: d)
    subscription_discount.apply_to(voucher)

    assert_equal 1693.5,voucher.total
  end

  test "If discount is greater, just cover 100 percent" do

    voucher = Voucher.create
    (1..10).each {|x| voucher.add_item(VoucherItem.create(amount: 200))}
    total = voucher.total
    elements_in_voucher = voucher.voucher_items.count
    assert_equal total, 2000
    d = Discount.create(value: 5000)
    subscription_discount = SubscriptionDiscount.create(discount: d)
    subscription_discount.apply_to(voucher)

    assert_equal 0,voucher.total
    assert_equal voucher.voucher_items.count, elements_in_voucher+1


    voucher = Voucher.create
    (1..10).each {|x| voucher.add_item(VoucherItem.create(amount: 200))}
    total = voucher.total
    elements_in_voucher = voucher.voucher_items.count
    assert_equal total, 2000
    d = Discount.create(value: 3226, unit: :percentage)
    subscription_discount = SubscriptionDiscount.create(discount: d)
    subscription_discount.apply_to(voucher)

    assert_equal 0,voucher.total
    assert_equal voucher.voucher_items.count, elements_in_voucher+1
  end

end
