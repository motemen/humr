require 'humr'

describe Humr::Handler::Time do
  subject { Humr::Handler::Time.new }

  it 'parses Apache common log format' do
    subject.parse('17/Jul/2013:00:19:52 +0900').should_not be(nil)
  end

  it 'parses HTTP date format' do
    subject.parse('Tue, 16 Jul 2013 15:33:33 GMT').should_not be(nil)
  end

  it 'does not parse non-time string' do
    subject.parse('foobarbaz').should be(nil)
  end
end

describe Humr::Handler::URI do
  subject { Humr::Handler::URI.new }

  it 'parses URI-escaped string' do
    subject.format('/search?q=%E7%BE%8E%E9%A1%94%E5%99%A8').should_not be(nil)
  end

  it 'ignores non URI-escaped string' do
    subject.format('/foo/bar/baz').should be(nil)
  end
end
