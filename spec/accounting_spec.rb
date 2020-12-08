require 'spec_helper'

module Nicehash
  module Accounting
    RSpec.describe Endpoints do
      let(:client) { Client.new }

      describe '#fetch_currency(:currency)' do
        it 'returns account details for specified :currency' do
          curr = client.fetch_currency!(currency: 'BTC')
          expect(curr.active).to eq true
          curr = client.fetch_currency!(currency: 'LTC')
          expect(curr.active).not_to eq true
        end
      end

      describe '#fetch_total' do
        it 'returns account total across all currencies' do
          total = client.fetch_total!
          expect(total.total).to be_a(Accounting::Currency)
          expect(total.currencies.size).to be > 1
        end
      end

      describe '#fetch_activities(:currency, :params)' do
        it 'returns activities for specified :currency, filtered :params' do
          params = ActivitiesParams.new(limit: 3)
          activities = client.fetch_activities!(currency: 'BTC', params: params)
          expect(activities.length).to eq(3)
          expect(activities[0]).to be_a(Accounting::Activity)
        end
      end

      describe '#fetch_transactions(:currency, :params)' do
        it 'returns activities for specified :currency, filtered :params' do
          params = TransactionsParams.new(size: 3)
          txs = client.fetch_transactions!(currency: 'BTC', params: params)
          expect(txs.length).to eq(3)
          expect(txs[0]).to be_a(Accounting::Transaction)
        end
      end
    end
  end
end
