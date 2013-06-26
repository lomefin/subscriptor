class RemoveProductFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :product, :references
  end
end
