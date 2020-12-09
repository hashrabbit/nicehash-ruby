module Nicehash
  module Accounting
    class ActivitiesParams < BaseStruct
      attribute? :type, Types::String.enum(
        "DEPOSIT", "WITHDRAWAL", "HASHPOWER", "MINING", "EXCHANGE",
        "UNPAID_MINING", "OTHER"
      )
      attribute? :timestamp, Types.Constructor(Integer) { |v| v.to_i * 1000 }
      attribute? :stage, Types::String.default('ALL'.freeze)
      attribute? :limit, Types::Integer.default(10)
    end
  end
end
