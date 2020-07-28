module Nicehash
  class Client
    extend Dry::Initializer

    option :host, default: proc { ENV['NICEHASH_HOST'] }
    option :api_key, default: proc { ENV['NICEHASH_API_KEY'] },        reader: :private
    option :api_secret, default: proc { ENV['NICEHASH_API_SECRET'] },  reader: :private
    option :org_id, default: proc { ENV['NICEHASH_ORGANIZATION_ID'] }, reader: :private
    option :request, default: proc { ->(args) { RestClient::Request.execute(args) } }

    include Info::Endpoints
    include Accounting::Endpoints
    include Mining::Endpoints
    include Hashpower::Endpoints
    include Pools::Endpoints

    def get
      @get ||= Api.Call(request: Api::Request.new(api_opts(:get)))
    end

    def post
      @post ||= Api.Call(request: Api::Request.new(api_opts(:post)))
    end

    def delete
      @delete ||= Api.Call(request: Api::Request.new(api_opts(:delete)))
    end

    def valid_params!(params, klass)
      return if params.is_a?(klass)

      raise ParamsError.new(klass)
    end

    def auth
      @auth ||= Api::Auth.new(key: api_key, secret: api_secret, org_id: org_id)
    end

    private

    def api_opts(method)
      {
        host: host,
        method: method,
        auth: auth,
        request: request
      }
    end
  end
end
