require 'spec_helper'

module Nicehash
  module Accounting
    RSpec.describe Endpoints do
      let(:client) { Client.new(raise_api_error: true) }

      describe '#fetch_currency(:currency)' do
        it 'returns account details for specified :currency' do
          curr = client.fetch_currency(currency: 'BTC')
          expect(curr.active).to eq true
          curr = client.fetch_currency(currency: 'LTC')
          expect(curr.active).not_to eq true
        end
      end

      describe '#fetch_total' do
        it 'returns account total across all currencies' do
          total = client.fetch_total
          expect(total.total).to be_a(Accounting::Currency)
          expect(total.currencies.size).to be > 1
        end
      end
    end
  end
end
