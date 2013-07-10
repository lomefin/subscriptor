class Tier < ActiveRecord::Base
  belongs_to :charge

  def price_per_unit
    Rails::logger.debug "Getting Price per unit (cents): " + price_per_unit_cents.to_s
    @price_per_unit_cents/100
  end
  def price_per_unit=(value)
    Rails::logger.debug "Price per unit: " + value.to_s
    @price_per_unit_cents = value*100
    Rails::logger.debug "Setting Price per unit (cents): " + price_per_unit_cents.to_s
  end
  def cost_for(units)
    units_to_charge = [units,self.max_units].min
    Rails::logger.debug "Units to charge: " + units_to_charge.to_s
    tier_cost = units_to_charge * price_per_unit
    Rails::logger.debug "Price per unit: $" + price_per_unit.to_s
    Rails::logger.debug "Tier cost: $"+tier_cost.to_s
    remaining_units = units - units_to_charge
    [tier_cost,remaining_units]
  end
end
