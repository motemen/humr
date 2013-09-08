require 'spec_helper'
require 'humr/handler/time'

describe Humr::Handler::Time do
  subject { Humr::Handler::Time.new }

  it 'parses Apache common log format' do
    expect(subject.parse('17/Jul/2013:00:19:52 +0900')).to be_kind_of(Time)
  end

  it 'parses HTTP date format' do
    expect(subject.parse('Tue, 16 Jul 2013 15:33:33 GMT')).to be_kind_of(Time)
  end

  it 'parses ctime format' do
    expect(subject.parse('Tue Jul 23 13:04:11 2013 +0900')).to be_kind_of(Time)
  end

  it 'does not parse non-time string' do
    expect(subject.parse('foobarbaz')).to be(nil)
  end
end
