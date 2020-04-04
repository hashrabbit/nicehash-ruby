module Nicehash
  module Pools
    class Log < BaseStruct
      attribute :level, Types::String.enum('INFO', 'WARNING', 'SEVERE')
      attribute :timestamp, Types::JSON::Time
      attribute :poolVerificationMessage, Types::String
      attribute :message, Types::String
    end
  end
end
