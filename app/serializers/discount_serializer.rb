class DiscountSerializer < ActiveModel::Serializer
  attributes :id, :applied_to, :unit
  has_one :plan
end
