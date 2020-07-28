module Nicehash
  MockAuth = Struct.new(:key, :secret, :org_id) do
    def call(**kwargs)
      'auth_signature'
    end
  end

  RSpec.describe Api::Request do
    before { extend Dry::Monads[:result] }

    let(:subject) do
      Api::Request.new(
        host: host,
        method: method,
        auth: auth,
        request: request)
    end
    let(:host) { 'host' }
    let(:method) { 'method' }
    let(:auth) { MockAuth.new('api_key', 'api_secret', 'org_id') }
    let(:request) { ->(args) { request_client.call(args) } }
    let(:request_client) { double('request client') }

    describe '#call' do
      let(:path) { '/path/to/resource' }
      let(:query) { { q1: 'query1', q2: 'query2' } }
      let(:body) { { payload: 'body payload' } }
      let(:req_args) { { path: path, query: query, body: body } }
      let(:req_headers) { hash_including(:content_type => :json,
                                         :params => query,
                                         :x_auth => 'auth_signature',
                                         :x_organization_id => 'org_id',
                                         :x_nonce => anything,
                                         :x_request_id => anything,
                                         :x_time => anything) }
      let(:req_opts) { hash_including(:method => method,
                                      :url => "#{host}#{path}",
                                      :payload => /body payload/,
                                      :headers => req_headers) }
      before do
        allow(request_client).to receive(:call).with(req_opts) { request_result.call }
      end

      context 'when the request client returns a value' do
        let(:request_result) { -> { :ret_val } }

        it 'returns a Success of the return value' do
          expect(subject.call(req_args)).to eq Success(:ret_val)
        end
      end

      context 'when the request client raises an exception with response' do
        let(:err) { RestClient::ExceptionWithResponse.new(:response) }
        let(:request_result) { -> { raise err } }

        it 'returns a Failure of the exception' do
          expect(subject.call(req_args)).to eq Failure(err)
        end
      end
    end
  end
end
