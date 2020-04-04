require 'spec_helper'

module Nicehash
  module Mining
    RSpec.describe Endpoints do
      let(:client) { Client.new(raise_api_error: true) }

      describe '#fetch_algorithms' do
        it 'returns details on all available algorithms' do
          algos = client.fetch_algorithms
          expect(algos.size).to be > 1
          expect(algos[1].displayMarketFactor).to eq 'PH'
        end
      end

      describe '#fetch_algorithm(:name)' do
        it 'returns details on the algorithm specified by :name' do
          algo = client.fetch_algorithm(name: 'SHA256')
          expect(algo.order).to eq 1
        end
      end
    end
  end
end
