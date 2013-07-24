module Connectors
  class FamilinkConnector < BaseConnector
    def self.usage_for(user,date_from=1.month.ago, date_to=1.days.ago)
      user * 3
    end
  end
end