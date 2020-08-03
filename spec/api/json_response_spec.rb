module Nicehash
  RSpec.describe Api::JsonResponse do
    before { extend Dry::Monads[:result] }

    let(:subject) { Api::JsonResponse.new }
    describe '#call' do
      context 'when the request result contains a success' do
        let(:request_object) { double('request object') }
        let(:request_result) { Success(request_object) }

        context 'when the request object json is invalid' do
          before do
            allow(request_object).to receive(:body).and_return('invalid json')
          end

          it 'return a failure with a JsonError' do
            response_result = subject.call(request_result)
            expect(response_result).to be_failure
            expect(response_result.failure).to be_a JsonError
          end
        end

        context 'when the request object json is valid' do
          before do
            allow(request_object).to receive(:body).and_return("{\"valid\": \"json\"}")
          end

          it 'returns a success of the parsed json body' do
            expect(subject.call(request_result)).to eq Success('valid' => 'json')
          end
        end
      end

      context 'when the request result contains a failure' do
        let(:request_object) { double('request object') }
        let(:request_result) { Failure(request_object) }

        context 'when the request object json is invalid' do
          before do
            allow(request_object).to receive(:response).and_return(request_object)
            allow(request_object).to receive(:body).and_return('invalid json')
          end

          it 'return a failure with a JsonError' do
            response_result = subject.call(request_result)
            expect(response_result).to be_failure
            expect(response_result.failure).to be_a JsonError
          end
        end

        context 'when the request object json is valid' do
          before do
            allow(request_object).to receive(:response).and_return(request_object)
            allow(request_object).to receive(:body).and_return({error_id: '42', errors: ['its wrong', 'and bad']}.to_json)
            allow(request_object).to receive(:code).and_return('response code')
          end

          it 'return a failure with an ApiError' do
            response_result = subject.call(request_result)
            expect(response_result).to be_failure
            expect(response_result.failure).to be_an ApiError
            expect(response_result.failure.to_s).to eq "Code: response code\nError_id: 42\nits wrong\\nand bad"
          end
        end
      end
    end
  end
end
