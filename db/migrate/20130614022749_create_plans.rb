class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.references :product, index: true

      t.timestamps
    end
  end
end
