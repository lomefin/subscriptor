class PlanTemplateToPlanAndPlanToSuscription < ActiveRecord::Migration
  def up
    rename_table :plans, :subscriptions
    rename_table :plan_templates, :plans
  end

  def down
    rename_table :plans, :plan_templates
    rename_table :subscriptions, :plans
  end
end
