module Nicehash
  module Accounting

    SubEnumName = Types.Constructor(String) { |obj| obj['enumName'] }

    class Transaction < BaseStruct
      attribute :id, Types::Uuid
      attribute :created, Types::TimeInt
      attribute :currency, SubEnumName
      attribute :amount, Types::FloatString
      attribute :type, SubEnumName
      attribute :fromOwner, Types::Uuid
      attribute :fromAccountType, SubEnumName
      attribute :purpose, SubEnumName
      attribute :serviceRef, Types::Uuid
    end
  end
end
