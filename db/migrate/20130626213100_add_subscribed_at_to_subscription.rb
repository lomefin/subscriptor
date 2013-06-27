class AddSubscribedAtToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :unsubscribed_at, :datetime
  end
end
