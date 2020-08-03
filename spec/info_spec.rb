require 'spec_helper'

module Nicehash
  module Info
    RSpec.describe Endpoints do
      let(:client) { Client.new }

      describe '#fetch_info_flags' do
        it 'returns the main config flags' do
          flags = client.fetch_info_flags!
          expect(flags.size).to be > 0
          a_flag = flags.find { |f| f.flagName == 'CREATE_ORDERS_ENABLED'}
          expect(a_flag.flagValue).to eq true
        end
      end
    end
  end
end
