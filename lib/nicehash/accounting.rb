require 'nicehash/accounting/activities_params'
require 'nicehash/accounting/activity'
require 'nicehash/accounting/currency'
require 'nicehash/accounting/total'
require 'nicehash/accounting/transaction'
require 'nicehash/accounting/transactions_params'

module Nicehash
  module Accounting
    module Endpoints
      include ExceptionEndpoints
      exception_endpoint! :fetch_currency
      exception_endpoint! :fetch_total
      exception_endpoint! :fetch_activities
      exception_endpoint! :fetch_transactions

      def fetch_currency(currency:)
        details = get.call(path: "/main/api/v2/accounting/account2/#{currency}")
        details.fmap { |details| Currency.new(details) }
      end

      def fetch_activities(currency:, params: ActivitiesParams.new)
        valid_params!(params, ActivitiesParams)
        details = get.call(
          path: "/main/api/v2/accounting/activity/#{currency}",
          query: params.to_h.compact
        )
        details.fmap { |list| list.map { |fields| Activity.new(fields) } }
      end

      def fetch_total
        total = get.call(path: '/main/api/v2/accounting/accounts2/')
        total.fmap { |total| Total.new(total) }
      end

      def fetch_transactions(currency:, params: TransactionsParams)
        valid_params!(params, TransactionsParams)
        transactions = get.call(
          path: "/main/api/v2/accounting/transactions/#{currency}",
          query: params.to_h.compact
        )
        transactions.fmap { |txs| txs['list'].map { |tx| Transaction.new(tx) } }
      end
    end
  end
end
