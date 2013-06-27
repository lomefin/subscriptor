class PlanBasedOnTemplate < ActiveRecord::Migration
  def change
    add_column :plans, :plan_template_id, :integer 
  end
end
