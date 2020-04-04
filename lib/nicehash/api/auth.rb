require 'openssl'

module Nicehash
  module Api
    class Auth
      attr_reader :org_id, :key, :secret

      def initialize(key:, secret:, org_id:)
        @org_id = org_id
        @key = key
        @secret = secret
      end

      def call(time:, nonce:, method:, path:, query: {}, body: {})
        fields = [key, time, nonce, nil, org_id, nil, method, path]
        fields << URI.encode_www_form(query) unless query.empty?
        fields += [nil, body.to_json] unless body.empty?
        hmac = digest.update(fields.join(zb))
        hmac.update(zb) if [query, body].all?(&:empty?)
        "#{key}:#{hmac}"
      end

      private

      def message(fields, query, body)
        fields << URI.encode_www_form(query) unless query.empty?
        fields += [nil, body.to_json] unless body.empty?
        hmac = digest.update(fields.join(zb))
        [query, body].all?(&:empty?) ? hmac.update(zb) : hmac
      end

      def digest
        OpenSSL::HMAC.new(secret, OpenSSL::Digest::SHA256.new)
      end

      def zb
        "\0"
      end
    end
  end
end
