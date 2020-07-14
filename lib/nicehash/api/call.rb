module Nicehash
  module Api
    class Call
      include Dry::Monads[:result]
      extend Dry::Initializer

      option :request
      option :response

      def call(**request_opts)
        response.call(request.call(request_opts))
      end
    end
  end
end
