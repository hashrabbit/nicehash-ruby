require 'dry-initializer'
require 'dry/monads'
require 'dry/monads'
require 'dry/monads/do'

module Nicehash
  Error = Class.new(StandardError)

  class ClientError < Error
    def initialize(value)
      super("Client error: #{value}")
    end
  end

  class JsonError < Error
    def initialize(value)
      super("Error handling JSON: #{value}")
    end
  end

  class ApiError < Error
    attr_reader :code, :error_id, :errors

    def initialize(response)
      @code = response['code']
      @error_id = response['error_id']
      @errors = response['errors']
      super("Code: #{code}\nError_id: #{error_id}\n#{errors.join('\n')}")
    end
  end

  class ParamsError < Error
    def initialize(klass)
      super("Params Error: You must supply a #{klass} to this API method")
    end
  end
end

require 'nicehash/version'
require 'nicehash/time'
require 'nicehash/types'
require 'nicehash/api'
require 'nicehash/server_time'
require 'nicehash/exception_endpoints'
require 'nicehash/info'
require 'nicehash/accounting'
require 'nicehash/hashpower'
require 'nicehash/mining'
require 'nicehash/pools'

require 'nicehash/client'
