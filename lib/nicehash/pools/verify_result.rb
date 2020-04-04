require 'nicehash/pools/log'

module Nicehash
  module Pools
    class VerifyResult < BaseStruct
      attribute :success, Types::Bool
      attribute :difficultyCorrect, Types::Bool
      attribute :highestDifficulty, Types::FloatString
      attribute? :highestDifficultyFormatted, Types::String
      attribute :logs, Types.Array(Log)
    end
  end
end
