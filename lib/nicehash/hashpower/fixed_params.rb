module Nicehash
  module Hashpower
    class FixedParams < BaseStruct
      attribute :algorithm, Types::Algorithms
      attribute :limit, Types::PositiveFloat
      attribute :market, Types::String
    end
  end
end
