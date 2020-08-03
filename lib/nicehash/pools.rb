require 'nicehash/pools/pool'
require 'nicehash/pools/verify_params'
require 'nicehash/pools/verify_result'

module Nicehash
  module Pools
    module Endpoints
      include ExceptionEndpoints
      exception_endpoint! :fetch_pools
      exception_endpoint! :fetch_pool
      exception_endpoint! :upsert_pool
      exception_endpoint! :verify_pool
      exception_endpoint! :delete_pool

      def fetch_pools
        pools = get.call(path: '/main/api/v2/pools')
        pools.fmap { |pools| pools['list'].map { |pool| Pool.new(pool) } }
      end

      def fetch_pool(id:)
        pool = get.call(path: "/main/api/v2/pool/#{id}")
        pool.fmap { |pool| Pool.new(pool) }
      end

      def upsert_pool(params:)
        valid_params!(params, Pool)
        pool = post.call(
          path: '/main/api/v2/pool', body: params.to_h.compact
        )
        pool.fmap { |pool| Pool.new(pool) }
      end

      def verify_pool(params:)
        valid_params!(params, VerifyParams)
        fields = post.call(
          path: '/main/api/v2/pools/verify', body: params.to_h.compact
        )
        fields.fmap { |fields| VerifyResult.new(fields) }
      end

      def delete_pool(id:)
        del = delete.call(path: "/main/api/v2/pool/#{id}")
        del.fmap { |del| Deleted.new(del) }
      end
    end
  end
end
