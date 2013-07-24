class Tier < ActiveRecord::Base
  belongs_to :plan

  def price_per_unit
    @price_per_unit_cents/100
  end
  def price_per_unit=(value)
    @price_per_unit_cents = value*100
  end
  def cost_for(units)
    units_to_charge = [units,self.max_units].min
    tier_cost = units_to_charge * price_per_unit
    remaining_units = units - units_to_charge
    [tier_cost,remaining_units]
  end
end
