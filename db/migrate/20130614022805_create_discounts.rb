class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.integer :applied_to
      t.string :unit
      t.references :plan, index: true

      t.timestamps
    end
  end
end
