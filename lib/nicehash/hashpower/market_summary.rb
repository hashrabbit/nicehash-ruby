require 'nicehash/hashpower/market_prof'

module Nicehash
  module Hashpower
    class MarketSummary < BaseStruct
      attribute :payingPrice, Types::FloatString
      attribute :profs, Types.Array(MarketProf)
    end
  end
end
