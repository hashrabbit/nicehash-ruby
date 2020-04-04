module Nicehash
  class Client

    attr_reader :host, :auth, :raise_api_error, :response

    def initialize(opts = {})
      @host = opts.fetch(:host, ENV['NICEHASH_HOST'])
      api_key = opts.fetch(:api_key, ENV['NICEHASH_API_KEY'])
      api_secret = opts.fetch(:api_secret, ENV['NICEHASH_API_SECRET'])
      org_id = opts.fetch(:org_id, ENV['NICEHASH_ORGANIZATION_ID'])
      @auth = Api::Auth.new(key: api_key, secret: api_secret, org_id: org_id)
      @raise_api_error = opts.fetch(:raise_api_error, false)
    end

    include Info::Endpoints
    include Accounting::Endpoints
    include Mining::Endpoints
    include Hashpower::Endpoints
    include Pools::Endpoints

    def get
      @get ||= Api::Request.new(api_opts(:get))
    end

    def post
      @post ||= Api::Request.new(api_opts(:post))
    end

    def delete
      @delete ||= Api::Request.new(api_opts(:delete))
    end

    def valid_params!(params, klass)
      return if params.is_a?(klass)

      raise ParamsError.new(klass)
    end

    private

    def api_opts(method)
      { host: host, method: method, auth: auth, raise_error: raise_api_error }
    end
  end
end
