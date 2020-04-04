module Nicehash
  module Hashpower
    class MarketProf < BaseStruct
      attribute :type, Types::OrderTypes
      attribute :speed, Types::FloatString
      attribute :price, Types::FloatString
      attribute :rigCount, Types::IntString
      attribute :orderCount, Types::IntString
    end
  end
end
