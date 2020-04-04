require 'nicehash/info/flag'

module Nicehash
  module Info
    module Endpoints
      def fetch_info_flags
        flags = get.call(path: '/main/api/v2/info/flags/')['list']
        flags.map { |f| Flag.new(f) }
      end
    end
  end
end
