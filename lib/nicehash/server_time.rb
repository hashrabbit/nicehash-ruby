module Nicehash
  # There's a rule in the NiceHash v2 API that states if your local clock is
  # more than 5 minutes off, measured in microseconds, you need to use their
  # server's time for your timestamp header. This class was built to facilitate
  # that, but our local use has no need for it.

  class ServerTime

    attr_reader :response

    def initialize
      @host = 'https://api2.nicehash.com'
      @path = '/api/v2/time'
    end

    def call
      @response = RestClient.get("#{@host}#{@path}")
      JSON.parse(response)['serverTime']
    end
  end
end
