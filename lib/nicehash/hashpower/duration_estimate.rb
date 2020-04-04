module Nicehash
  module Hashpower
    class DurationEstimate < BaseStruct
      attribute :estimateDurationInSeconds, Types::Integer

      def to_i
        estimateDurationInSeconds
      end
    end
  end
end
