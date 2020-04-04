module Nicehash
  Error = Class.new(StandardError)

  class ApiError < Error
    attr_reader :code, :error_id, :errors

    def initialize(response)
      body = JSON.parse(response.body)
      @code = response.code
      @error_id = body['error_id']
      @errors = body['errors']
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
require 'nicehash/info'
require 'nicehash/accounting'
require 'nicehash/hashpower'
require 'nicehash/mining'
require 'nicehash/pools'

require 'nicehash/client'
