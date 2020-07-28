module Nicehash
  module Api
    class Call
      include Dry::Monads[:result]
      extend Dry::Initializer

      option :request, default: proc { Api::Request.new(
        host: ENV['NICEHASH_HOST'],
        method: :get,
        auth: Api::Auth.new(key: ENV['NICEHASH_API_KEY'],
                            secret: ENV['NICEHASH_API_SECRET'],
                            org_id: ENV['NICEHASH_ORGANIZATION_ID']),
        request: ->(args) { RestClient::Request.execute(args) }) }
      option :response, default: proc { Api::JsonResponse.new }

      def call(**request_opts)
        response.call(request.call(request_opts))
      end
    end

    def self.Call(kwargs)
      Call.new(kwargs)
    end
  end
end
