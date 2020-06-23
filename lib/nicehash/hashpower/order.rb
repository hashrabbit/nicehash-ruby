require 'nicehash/hashpower/algorithm'
require 'nicehash/hashpower/bridge'
require 'nicehash/hashpower/code_desc'
require 'nicehash/pools/pool'

module Nicehash
  module Hashpower
    class Order < BaseStruct
      attribute :id, Types::Uuid
      attribute :alive, Types::Bool
      attribute :price, Types::FloatString
      attribute :limit, Types::FloatString
      attribute :amount, Types::FloatString
      attribute :availableAmount, Types::FloatString
      attribute :payedAmount, Types::FloatString
      attribute :type, CodeDesc
      attribute :market, Types::Markets
      attribute :algorithm, Algorithm
      attribute :status, CodeDesc
      attribute :createdTs, Types::JSON::Time
      attribute :updatedTs, Types::JSON::Time
      attribute :startTs, Types::JSON::Time
      attribute :endTs, Types::JSON::Time
      attribute :pool, Pools::Pool
      attribute :acceptedCurrentSpeed, Types::FloatString
      attribute :displayMarketFactor, Types::String
      attribute :marketFactor, Types::IntString
      attribute :rigsCount, Types::IntString
      attribute :estimateDurationInSeconds, Types::IntString
      attribute? :bridges, Types.Array(Bridge)
      attribute :organizationId, Types::Uuid
      attribute :creatorUserId, Types::Uuid
      attribute :requestId, Types::String
    end
  end
end
