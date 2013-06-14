class TierSerializer < ActiveModel::Serializer
  attributes :id, :name, :max_units
  has_one :charge
end
