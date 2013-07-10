class AddConnectorToProduct < ActiveRecord::Migration
  def change
    add_column :products, :connector, :string
  end
end
