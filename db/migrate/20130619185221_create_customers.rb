class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.references :product, index: true
      t.integer :provider_id

      t.timestamps
    end
  end
end
