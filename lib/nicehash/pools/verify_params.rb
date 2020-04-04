module Nicehash
  module Pools
    class VerifyParams < BaseStruct
      attribute :miningAlgorithm, Types::Algorithms
      attribute :poolVerificationServiceLocation, Types::String
      attribute :stratumHost, Types::String
      attribute :stratumPort, Types::Coercible::Integer
      attribute :username, Types::String
      attribute :password, Types::String
    end
  end
end
