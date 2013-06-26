class PlansAndCustomers < ActiveRecord::Migration
  def change
    add_column :plans, :customer_id, :integer
    add_column :plans, :valid_until, :date
  end
end
