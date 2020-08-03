require 'spec_helper'

module Nicehash
  module Pools
    RSpec.describe Endpoints do
      let(:client) { Client.new }
      let(:pools) { client.fetch_pools! }

      describe '#fetch_pools' do
        it 'retrieves Pool configurations' do
          expect(pools.size).to be > 0
        end
      end

      describe '#fetch_pool' do
        it 'retrieves a specific Pool configuration' do
          pool = client.fetch_pool!(id: pools[0].id)
          expect(pool.stratumPort).to be > 0
        end
      end

      describe '#upsert_pool' do
        let(:params) {
          Pools::Pool.new(
            name: 'Delete Pool', algorithm: 'SHA256',
            stratumHostname: 'delete.pool.com', stratumPort: '3333',
            username: 'delete-me', password: 'x'
          )
        }

        it 'creates a new Pool resource; removed with #delete_pool' do
          pool = client.upsert_pool!(params: params)
          expect { Types::Uuid[pool.id] }.not_to raise_error
          del = client.delete_pool!(id: pool.id)
          expect(del.success).to eq true
        end
      end

      describe '#verify_pool' do
        let(:params) {
          Pools::VerifyParams.new(
            miningAlgorithm: 'SHA256',
            poolVerificationServiceLocation: 'USA',
            stratumHost: 'bsv.viabtc.com', stratumPort: '8888',
            username: 'test-worker', password: 'd=500000'
          )
        }

        it 'produces a Pool verification report, from the submitted params' do
          ver = client.verify_pool!(params: params)
          expect(ver.success).to eq true
        end
      end
    end
  end
end
