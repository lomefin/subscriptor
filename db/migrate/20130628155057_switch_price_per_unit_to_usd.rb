class SwitchPricePerUnitToUsd < ActiveRecord::Migration
  def up
    change_column :tiers, :price_per_unit_currency, :string, default: 'USD'
    rename_column :tiers, :price_per_unit_pesos, :price_per_unit_cents
  end
  
  def down
    change_column :tiers, :price_per_unit_currency, :string,  default: 'CLP'
    rename_column :tiers, :price_per_unit_cents, :price_per_unit_pesos
  end
end
