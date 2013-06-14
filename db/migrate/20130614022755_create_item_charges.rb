class CreateItemCharges < ActiveRecord::Migration
  def change
    create_table :item_charges do |t|
      t.string :description
      t.date :due
      t.references :plan, index: true

      t.timestamps
    end
  end
end
