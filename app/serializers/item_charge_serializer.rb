class ItemChargeSerializer < ActiveModel::Serializer
  attributes :id, :description, :due
  has_one :plan
end
