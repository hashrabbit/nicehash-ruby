require 'nicehash/hashpower/my_order_params'
require 'nicehash/hashpower/my_order'
require 'nicehash/hashpower/order'
require 'nicehash/hashpower/order_params'
require 'nicehash/hashpower/price_limit_params'
require 'nicehash/hashpower/duration_params'
require 'nicehash/hashpower/duration_estimate'
require 'nicehash/hashpower/fixed_params'
require 'nicehash/hashpower/fixed_price'
require 'nicehash/hashpower/market_params'
require 'nicehash/hashpower/market_summary'

module Nicehash
  module Hashpower
    module Endpoints
      include ExceptionEndpoints
      exception_endpoint! :compute_estimate_duration
      exception_endpoint! :fixed_order_price
      exception_endpoint! :fetch_market_summary
      exception_endpoint! :fetch_my_orders
      exception_endpoint! :fetch_order
      exception_endpoint! :create_order
      exception_endpoint! :refill_order
      exception_endpoint! :update_order_price_limit
      exception_endpoint! :delete_order

      def compute_estimate_duration(params:)
        valid_params!(params, DurationParams)
        duration = post.call(
          path: '/main/api/v2/hashpower/orders/calculateEstimateDuration',
          body: params.to_h.compact
        )
        duration.fmap { |duration| DurationEstimate.new(duration) }
      end

      def fixed_order_price(params:)
        valid_params!(params, FixedParams)
        fields = post.call(
          path: '/main/api/v2/hashpower/orders/fixedPrice',
          body: params.to_h.compact
        )
        fields.fmap { |fields| FixedPrice.new(fields) }
      end

      def fetch_market_summary(params:)
        valid_params!(params, MarketParams)
        fields = get.call(
          path: '/main/api/v2/hashpower/orders/summary',
          query: params.to_h.compact
        )
        fields.fmap { |fields| MarketSummary.new(fields) }
      end

      def fetch_my_orders(params:)
        valid_params!(params, MyOrderParams)
        orders = get.call(
          path: '/main/api/v2/hashpower/myOrders', query: params.to_h.compact
        )
        orders.fmap { |orders| orders['list'].map { |order| MyOrder.new(order) } }
      end

      def fetch_order(id:)
        order = get.call(path: "/main/api/v2/hashpower/order/#{id}")
        order.fmap { |order| Order.new(order) }
      end

      def create_order(params:)
        valid_params!(params, OrderParams)
        order = post.call(
          path: '/main/api/v2/hashpower/order', body: params.to_h.compact
        )
        order.fmap { |order| Order.new(order) }
      end

      def refill_order(id:, amount:)
        order = post.call(
          path: "/main/api/v2/hashpower/order/#{id}/refill",
          body: { amount: amount }
        )
        order.fmap { |order| Order.new(order) }
      end

      def update_order_price_limit(id:, params:)
        valid_params!(params, PriceLimitParams)
        order = post.call(
          path: "/main/api/v2/hashpower/order/#{id}/updatePriceAndLimit",
          body: params.to_h.compact
        )
        order.fmap { |order| Order.new(order) }
      end

      def delete_order(id:)
        order = delete.call(path: "/main/api/v2/hashpower/order/#{id}")
        order.fmap { |order| Order.new(order) }
      end
    end
  end
end
