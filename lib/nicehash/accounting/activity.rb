module Nicehash
  module Accounting
    class Activity < BaseStruct
      attribute :id, Types::Uuid
      attribute :type, Types::String
      attribute :time, Types::TimeInt
      attribute :status, Types::String
      attribute :algorithm, Types::Algorithms
      attribute :hashPowerOrderType, Types::String
      attribute :paidAmount, Types::FloatString
      attribute :feeAmount, Types::FloatString
      attribute :startTs, Types::TimeInt
      attribute :updatedTs, Types::TimeInt
      attribute :expiredTs, Types::TimeInt
      attribute :estDurationInSec, Types::Coercible::Integer
      attribute :orderLifetime, Types::Coercible::Integer
      attribute :price, Types::FloatString
      attribute :progress, Types::FloatString
      attribute :pool, Types::String
    end
  end
end
