module Nicehash
  module Hashpower
    class MyOrderParams < BaseStruct
      attribute? :algorithm, Types::Algorithms
      attribute? :status, Types::OrderStates
      attribute :active, Types::Bool.default(true)
      attribute? :market, Types::Markets
      attribute :ts, Types::Integer
      attribute :op, Types::String.enum('GT', 'GE', 'LT', 'LE')
      attribute :limit, Types::Integer.default(100)
    end
  end
end
