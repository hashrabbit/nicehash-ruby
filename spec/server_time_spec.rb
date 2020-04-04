require 'spec_helper'

module Nicehash
  RSpec.describe ServerTime do
    describe '.call' do
      it 'returns the server time in ms' do
        now_ms = Time.now.to_ms
        st = ServerTime.new.call
        expect(st - now_ms).to be <= 999
      end
    end
  end
end
