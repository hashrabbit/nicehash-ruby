module Nicehash
  module Hashpower
    class FixedPrice < BaseStruct
      attribute :fixedPrice, Types::PositiveFloat
      attribute :fixedMax, Types::PositiveFloat

      def to_f
        fixedPrice
      end
    end
  end
end
