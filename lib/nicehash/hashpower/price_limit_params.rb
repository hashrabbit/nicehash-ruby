module Nicehash
  module Hashpower
    class PriceLimitParams < BaseStruct
      attribute :price, Types::FloatString
      attribute :limit, Types::FloatString
      attribute :marketFactor, Types::IntString
      attribute :displayMarketFactor, Types::String
    end
  end
end
