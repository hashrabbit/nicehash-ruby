module Nicehash
  module Info
    class Flag < BaseStruct
      attribute :flagName, Types::String
      attribute :flagValue, Types::Bool
    end
  end
end
