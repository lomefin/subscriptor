class CreatePlanTemplates < ActiveRecord::Migration
  def change
    create_table :plan_templates do |t|
      t.string :name
      t.integer :version
      t.references :product, index: true

      t.timestamps
    end
  end
end
