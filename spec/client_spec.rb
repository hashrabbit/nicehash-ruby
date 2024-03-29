require 'spec_helper'

module Nicehash
  RSpec.describe Client do
    let(:client) {
      Client.new(host: 'https://api2.nicehash.com')
    }

    it 'contains a valid Auth object' do
      expect(client.auth).to be_a(Api::Auth)
    end
  end
end
