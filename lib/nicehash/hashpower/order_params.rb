module Nicehash
  module Hashpower
    class OrderParams < BaseStruct
      attribute :type, Types::OrderTypes
      attribute :algorithm, Types::Algorithms
      attribute :market, Types::Markets
      attribute :price, Types::FloatString
      attribute :limit, Types::FloatString
      attribute :amount, Types::FloatString
      attribute :poolId, Types::Uuid
      attribute :marketFactor, Types::IntString
      attribute :displayMarketFactor, Types::String
      attribute? :token, Types::Integer
    end
  end
end
