require 'spec_helper'
require 'humr/config'

describe Humr::Config do
  subject(:config) { Humr::Config.new }

  describe '#handlers' do
    it 'has initial value' do
      expect(config.handlers).to eq([ :url, :si, :time, :ua ])
    end
  end

  describe '#color' do
    it 'returns color tag for a handler' do
      expect(config.color(:url)).to eq(:green)
    end
  end
end
