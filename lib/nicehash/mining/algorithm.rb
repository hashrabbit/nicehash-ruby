module Nicehash
  module Mining
    class Algorithm < BaseStruct
      attribute :algorithm, Types::String
      attribute :title, Types::String
      attribute :enabled, Types::Bool
      attribute :miningFactor, Types::FloatString
      attribute :displayMiningFactor, Types::String
      attribute :marketFactor, Types::FloatString
      attribute :displayMarketFactor, Types::String
      attribute :minimalOrderAmount, Types::FloatString
      attribute :minSpeedLimit, Types::FloatString
      attribute :maxSpeedLimit, Types::FloatString
      attribute :priceDownStep, Types::FloatString
      attribute :minimalPoolDifficulty, Types::FloatString
      attribute :port, Types::IntString
      attribute :order, Types::IntString
      attribute :ordersEnabled, Types::Bool
      attribute :color, Types::String
    end
  end
end
