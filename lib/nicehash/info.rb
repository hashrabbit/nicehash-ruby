require 'nicehash/info/flag'

module Nicehash
  module Info
    module Endpoints
      include ExceptionEndpoints
      exception_endpoint! :fetch_info_flags

      def fetch_info_flags
        flags = get.call(path: '/main/api/v2/info/flags/')
        flags.fmap { |flags| flags['list'].map { |flag| Flag.new(flag) } }
      end
    end
  end
end
