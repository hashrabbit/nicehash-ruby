module Nicehash
  module Hashpower
    class DurationParams < BaseStruct
      attribute :type, Types::OrderTypes
      attribute :price, Types::PositiveFloat
      attribute :limit, Types::PositiveFloat
      attribute :amount, Types::PositiveFloat
      attribute :marketFactor, Types::String
      attribute :displaymarketFactor, Types::String
      attribute? :decreaseFee, Types::Bool
    end
  end
end
