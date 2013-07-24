class AddGracePeriodToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :grace_period, :integer, default: 5
  end
end
