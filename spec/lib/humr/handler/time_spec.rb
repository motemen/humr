require 'spec_helper'
require 'humr/handler/time'

describe Humr::Handler::Time do
  subject(:handler) { Humr::Handler::Time.new }

  include_examples 'humr_handler', :time, Humr::Handler::Time

  describe '#parse' do
    it 'parses Apache common log format' do
      expect(handler.parse('17/Jul/2013:00:19:52 +0900')).to be_kind_of(Time)
    end

    it 'parses HTTP date format' do
      expect(handler.parse('Tue, 16 Jul 2013 15:33:33 GMT')).to be_kind_of(Time)
    end

    it 'parses ctime format' do
      expect(handler.parse('Tue Jul 23 13:04:11 2013 +0900')).to be_kind_of(Time)
    end

    it 'does not parse non-time string' do
      expect(handler.parse('foobarbaz')).to be(nil)
    end
  end

end
