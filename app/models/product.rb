class Product < ActiveRecord::Base
  has_many :plans
  has_many :customers

  def request_usage_for_client(client_id)
    connector.usage_for(client_id)
  end

  def connector=(value)
    super(value.name.underscore)
  end

  def connector
    super.camelize.constantize
  end
  
end
