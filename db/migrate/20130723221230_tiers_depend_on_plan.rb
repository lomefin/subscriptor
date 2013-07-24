class TiersDependOnPlan < ActiveRecord::Migration
  def up
  	remove_column :tiers, :charge_id, :integer
  	add_column :tiers, :plan_id, :integer
  end
  def down
  	add_column :tiers, :charge_id, :integer
  	remove_column :tiers, :plan_id, :integer
  end
end
