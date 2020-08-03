require 'rest-client'
require 'securerandom'

module Nicehash
  module Api
    class Request
      include Dry::Monads[:result]
      extend Dry::Initializer

      option :host
      option :method
      option :auth
      option :request

      def call(path:, query: {}, body: {})
        @path = path
        @query = query
        @body = body
        @nonce = SecureRandom.uuid
        @time_ms = Time.now.to_ms.to_s

        make_request
      end

      private

      def make_request
        Success(request.call(request_args))
      rescue RestClient::ExceptionWithResponse => err
        Failure(err)
      end

      def request_args
        {
          method: method,
          url: "#{host}#{@path}",
          headers: header.merge(params: @query),
          payload: @body.empty? ? nil : @body.to_json
        }.compact
      end

      def header
        {
          content_type: :json, x_organization_id: auth.org_id, x_time: @time_ms,
          x_nonce: @nonce, x_request_id: @nonce, x_auth: signature
        }
      end

      def signature
        auth.call(
          time: @time_ms, nonce: @nonce, method: method.to_s.upcase, path: @path,
          query: @query, body: @body
        )
      end
    end
  end
end
