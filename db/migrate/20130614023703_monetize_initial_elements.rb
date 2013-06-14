class MonetizeInitialElements < ActiveRecord::Migration
  def change
    add_money :discounts, :value
    add_money :tiers, :price_per_unit
    add_money :item_charges, :cost
  end
end
