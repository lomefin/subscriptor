class CreateTiers < ActiveRecord::Migration
  def change
    create_table :tiers do |t|
      t.references :charge, index: true
      t.string :name
      t.integer :max_units

      t.timestamps
    end
  end
end
