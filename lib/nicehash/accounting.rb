require 'nicehash/accounting/currency'
require 'nicehash/accounting/total'

module Nicehash
  module Accounting
    module Endpoints
      include ExceptionEndpoints
      exception_endpoint! :fetch_currency
      exception_endpoint! :fetch_total

      def fetch_currency(currency:)
        details = get.call(path: "/main/api/v2/accounting/account2/#{currency}")
        details.fmap { |details| Currency.new(details) }
      end

      def fetch_total
        total = get.call(path: '/main/api/v2/accounting/accounts2/')
        total.fmap { |total| Total.new(total) }
      end
    end
  end
end
