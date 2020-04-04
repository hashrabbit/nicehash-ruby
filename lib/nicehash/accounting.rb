require 'nicehash/accounting/currency'
require 'nicehash/accounting/total'

module Nicehash
  module Accounting
    module Endpoints
      def fetch_currency(currency:)
        details = get.call(path: "/main/api/v2/accounting/account2/#{currency}")
        Currency.new(details)
      end

      def fetch_total
        total = get.call(path: '/main/api/v2/accounting/accounts2/')
        Total.new(total)
      end
    end
  end
end
