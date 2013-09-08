require 'spec_helper'
require 'humr/handler/si_prefix'

describe Humr::Handler::SIPrefix do
  subject { Humr::Handler::SIPrefix.new }

  it 'is registered as :si' do
    expect(Humr::Handler[:si]).to be(Humr::Handler::SIPrefix)
  end

  it 'handles kilo' do
    expect(subject.format('1000').uncolor).to eq('1.0k')
  end

  it 'handles mega' do
    expect(subject.format((20 * 1000 * 1000).to_s).uncolor).to eq('20M')
  end
end
