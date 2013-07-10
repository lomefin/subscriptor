require 'test_helper'

class VoucherTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Voucher knows the total" do
    values = Array.new(10).map {rand(1..1000)}
    total = values.sum
    voucher = Voucher.create()
    values.each { |v| voucher.add_item VoucherItem.new(amount: v, description: "Charge for " + v.to_s)}
    assert_not_equal 0, voucher.total
    assert_equal total, voucher.total
  end

  test "Voucher has all items" do
    voucher = Voucher.new
    values = Array.new(10).map {rand(1..1000)}
    values.each { |v| voucher.add_item VoucherItem.new(amount: v, description: "Charge for " + v.to_s)}    
    assert_equal voucher.voucher_items.count, 10
  end
end
