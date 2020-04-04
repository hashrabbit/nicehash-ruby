require 'spec_helper'

module Nicehash
  module Hashpower
    RSpec.describe Endpoints do
      let(:client) { Client.new(raise_api_error: true) }

      describe '#fetch_my_orders(:params)' do
        let(:params) {
          Hashpower::MyOrderParams.new(
            active: false, ts: Time.new(2020, 03, 20).to_ms, op: 'GT', limit: 10
          )
        }

        it 'returns my orders, filtered by :params' do
          orders = client.fetch_my_orders(params: params)
          expect(orders.size).to eq 10
        end
      end

      describe '#fetch_order(:id)' do
        it 'returns order details for specified :id' do
          order = client.fetch_order(id: "2be7a100-6ac1-4aec-92a9-9819a9724e1c")
          expect(order.alive).to eq false
        end
      end

      describe '#compute_estimate_duration' do
        let(:params) {
          Hashpower::DurationParams.new(
            type: 'FIXED', price: 0.0196, limit: 0.5, amount: 0.01,
            marketFactor: '1000000000000000', displaymarketFactor: 'PH'
          )
        }

        it 'retrieves an Order Estimated Duration' do
          est = client.compute_estimate_duration(params: params)
          expect(est.to_i).to be > 0
        end
      end

      describe '#fixed_order_price' do
        let(:params) {
          Hashpower::FixedParams.new(
            algorithm: 'SHA256', limit: 0.5, market: 'EU'
          )
        }

        it 'retrieves a Fixed Order Price request' do
          price = client.fixed_order_price(params: params)
          expect(price.fixedPrice).to be > 0.0
        end
      end

      describe '#fetch_market_summary' do
        let(:params) {
          Hashpower::MarketParams.new(algorithm: 'SHA256', market: 'EU')
        }

        it 'returns the summary' do
          sum = client.fetch_market_summary(params: params)
          expect(sum.payingPrice).to be > 0.0
        end
      end
    end
  end
end
