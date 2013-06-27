class RenameReferencesOnPlansAndSubscriptions < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :plan_template_id, :plan_id 
  end
end
