module Nicehash
  module Hashpower
    class MarketParams < BaseStruct
      attribute :algorithm, Types::Algorithms
      attribute :market, Types::Markets
    end
  end
end
