class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :product
end
