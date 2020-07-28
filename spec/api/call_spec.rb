module Nicehash
  RSpec.describe Api::Call do
    let(:request) { double('request') }
    let(:response) { double('response') }
    let(:subject) { Api.Call(request: request, response: response) }

    describe 'self.Call' do
      it 'Creates a new Call' do
        expect(subject).to be_a Api::Call
      end
    end

    describe '#call' do
      let(:request_result) { 'request result' }
      let(:response_result) { 'response result' }

      before do
        allow(request).to receive(:call).with(args: :args) { request_result }
        allow(response).to receive(:call).with(request_result) { response_result }
      end

      it 'passes the args through the request and response handlers' do
        expect(subject.call(args: :args)).to eq response_result
      end
    end
  end
end
