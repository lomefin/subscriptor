require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Save and reload connector" do
    connector = Connectors::BaseConnector

    p = Product.create(name:"Base Product",connector: connector)

    assert_equal p.connector.name, Connectors::BaseConnector.name

  end


  test "Usage For Works correctly" do
    module Connectors
      class FamilinkConnector
        def usage_for(user,date_from, date_to)
          user * 3
        end
      end
    end

    connector = Connectors::FamilinkConnector
    p = Product.create(name:"Base Product",connector: connector)

    assert_equal p.connector.new.usage_for(10,nil,nil), 30
  end
end
