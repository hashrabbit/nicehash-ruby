module Nicehash
  module Accounting
    class Total < BaseStruct
      attribute :total, Currency
      attribute :currencies, Types::Array.of(Currency)
    end
  end
end
