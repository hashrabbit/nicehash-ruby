module Nicehash
  module Accounting
    class Currency < BaseStruct
      attribute :currency, Types::String
      attribute? :active, Types::Bool
      attribute :totalBalance, Types::FloatString
      attribute :available, Types::FloatString
      attribute :pending, Types::FloatString
    end
  end
end
