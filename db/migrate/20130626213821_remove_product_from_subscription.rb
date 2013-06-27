class RemoveProductFromSubscription < ActiveRecord::Migration
  def change
    remove_reference :subscriptions, :product, index: true
  end
end
