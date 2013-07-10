class CreateSubscriptionDiscounts < ActiveRecord::Migration
  def change
    create_table :subscription_discounts do |t|
      t.references :subscription, index: true
      t.references :discount, index: true
      t.date :applied_on

      t.timestamps
    end
  end
end
