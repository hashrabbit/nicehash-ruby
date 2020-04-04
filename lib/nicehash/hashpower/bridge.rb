module Nicehash
  module Hashpower
    class Bridge < BaseStruct
      attribute :poolUrl, Types::String
      attribute :rigsCount, Types::IntString
      attribute :speedAccepted, Types::FloatString
      attribute :speedRewarded, Types::FloatString
      attribute :difficulty, Types::IntString
      attribute :miningFactor, Types::IntString
      attribute :miningFactorDisplay, Types::String
      attribute :status, Types::String
    end
  end
end
