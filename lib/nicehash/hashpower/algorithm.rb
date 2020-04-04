module Nicehash
  module Hashpower
    class Algorithm < BaseStruct
      attribute :algorithm, Types::String
      attribute :title, Types::String
      attribute :enabled, Types::Bool
      attribute :order, Types::IntString
    end
  end
end
