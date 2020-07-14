require 'json'

module Nicehash
  module Api
    class JsonResponse
      include Dry::Monads[:result, :try]

      def call(request_result)
        request_result
          .or do |err|
            parse(err.response.body)
              .or { |err| Failure(JsonError.new(err)) }
              .bind { |parsed| Failure(ApiError.new(parsed.merge(code: err.response.code))) }
          end
          .bind do |response|
            parse(response.body)
              .or { |err| Failure(JsonError.new(err)) }
          end
      end

      private

      def parse(json)
        Try(JSON::ParserError) { JSON.parse(json) }
          .to_result
      end
    end
  end
end
