class Discount < ActiveRecord::Base
  belongs_to :plan

  def value
    @value_pesos
  end
  def value=(value)
    @value_pesos = value
  end
end
