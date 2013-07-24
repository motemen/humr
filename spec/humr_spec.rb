require 'humr'
require 'term/ansicolor'

class String
  include Term::ANSIColor
end

describe Humr::Handler::Time do
  subject { Humr::Handler::Time.new }

  it 'parses Apache common log format' do
    subject.parse('17/Jul/2013:00:19:52 +0900').should be_kind_of(Time)
  end

  it 'parses HTTP date format' do
    subject.parse('Tue, 16 Jul 2013 15:33:33 GMT').should be_kind_of(Time)
  end

  it 'parses ctime format' do
    subject.parse('Tue Jul 23 13:04:11 2013 +0900').should be_kind_of(Time)
  end

  it 'does not parse non-time string' do
    subject.parse('foobarbaz').should be(nil)
  end
end

describe Humr::Handler::URI do
  subject { Humr::Handler::URI.new }

  it 'parses URI-escaped string' do
    subject.format('/search?q=%E7%BE%8E%E9%A1%94%E5%99%A8').uncolor.should eq('/search?q=美顔器')
  end

  it 'ignores non URI-escaped string' do
    subject.format('/foo/bar/baz').should be(nil)
  end
end

describe Humr::Handler::BinaryPrefix do
  subject { Humr::Handler::BinaryPrefix.new }

  it 'ignores small numbers' do
    subject.format('123').should be(nil)
  end

  it 'handles kilo' do
    subject.format('1024').uncolor.should eq('1.0Ki')
  end

  it 'handles mega' do
    subject.format((20 * 1024 * 1024).to_s).uncolor.should eq('20Mi')
  end
end
