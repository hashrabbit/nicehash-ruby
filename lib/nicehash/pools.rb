require 'nicehash/pools/pool'
require 'nicehash/pools/verify_params'
require 'nicehash/pools/verify_result'

module Nicehash
  module Pools
    module Endpoints
      def fetch_pools
        pools = get.call(path: '/main/api/v2/pools')['list']
        pools.map { |f| Pool.new(f) }
      end

      def fetch_pool(id:)
        pool = get.call(path: "/main/api/v2/pool/#{id}")
        Pool.new(pool)
      end

      def upsert_pool(params:)
        valid_params!(params, Pool)
        pool = post.call(
          path: '/main/api/v2/pool', body: params.to_h.compact
        )
        Pool.new(pool)
      end

      def verify_pool(params:)
        valid_params!(params, VerifyParams)
        fields = post.call(
          path: '/main/api/v2/pools/verify', body: params.to_h.compact
        )
        VerifyResult.new(fields)
      end

      def delete_pool(id:)
        del = delete.call(path: "/main/api/v2/pool/#{id}")
        Deleted.new(del)
      end
    end
  end
end
