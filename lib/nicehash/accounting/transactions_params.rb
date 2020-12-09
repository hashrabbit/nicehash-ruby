module Nicehash
  module Accounting
    class TransactionsParams < BaseStruct
      attribute? :type, Types::String.enum("DEPOSIT", "WITHDRAWAL", "MOVE")
      attribute? :purposes, Types.Array(String)
      attribute? :op, Types::String.enum("GT", "GE", "LT", "LE")
      attribute? :timestamp, Types.Constructor(Integer) { |v| v.to_i * 1000 }
      attribute? :page, Types::Integer.default(0)
      attribute? :size, Types::Integer.default(10)
    end
  end
end
