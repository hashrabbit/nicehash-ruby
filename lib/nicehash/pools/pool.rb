module Nicehash
  module Pools
    class Pool < BaseStruct
      attribute? :id, Types::Uuid
      attribute :name, Types::String
      attribute :algorithm, Types::Algorithms
      attribute :stratumHostname, Types::String
      attribute :stratumPort, Types::Coercible::Integer
      attribute :username, Types::String
      attribute :password, Types::String
      attribute? :status, Types::String
      attribute? :updatedTs, Types::JSON::Time
    end
  end
end
