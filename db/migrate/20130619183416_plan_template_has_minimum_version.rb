class PlanTemplateHasMinimumVersion < ActiveRecord::Migration
  def up
    change_column :plan_templates,:version, :integer, default: 1, null: false
  end
  def down
    change_column :plan_templates, :version, :integer
  end
end
