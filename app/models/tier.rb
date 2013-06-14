class Tier < ActiveRecord::Base
  belongs_to :charge

  monetize :price_per_unit_cents

  def cost_for(units)
    units_to_charge = [units,self.max_units].min
    tier_cost = units_to_charge * self.cost_per_unit
    remaining_units = units - units_to_charge
    [tier_cost,remaining_units]
  end
end
