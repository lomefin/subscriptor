class AddNextPaymentToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :next_payment, :date
  end
end
