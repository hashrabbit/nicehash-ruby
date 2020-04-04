require 'json'
require 'rest-client'
require 'securerandom'
require 'nicehash/api/failure'

module Nicehash
  module Api
    class Request
      attr_reader :method, :host, :auth, :raise_error

      def initialize(host:, method:, auth:, raise_error: false)
        @host = host
        @method = method
        @auth = auth
        @raise_error = raise_error
      end

      def call(path:, query: {}, body: {})
        @path = path
        @query = query
        @body = body
        @nonce = SecureRandom.uuid
        @time_ms = Time.now.to_ms.to_s
        JSON.parse(response.body)
      end

      private

      def response
        RestClient::Request.execute(request_args)
      rescue RestClient::ExceptionWithResponse => err
        raise ApiError.new(err.response) if raise_error

        Failure.new(
          JSON.parse(err.response.body).merge(code: err.response.code)
        )
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
