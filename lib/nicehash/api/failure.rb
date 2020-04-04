module Nicehash
  module Api
    class Failure < BaseStruct
      attribute :code, Types::Coercible::Integer
      attribute :error_id, Types::String.constrained(uuid_v4: true)
      attribute :errors, Types::JSON::Array
    end
  end
end
