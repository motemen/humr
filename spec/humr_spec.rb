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

describe Humr::Handler::UIString do
  subject { Humr::Handler::UIString.new } 

  it 'ignores non-ua string' do
    expect(subject.format('foo bar baz')).to be(nil)
  end

  it 'ignores non-ua string (HTTP request line)' do
    expect(subject.format('GET /foo/bar/1234 HTTP/1.0')).to be(nil)
  end

  it 'handles UA string (Chrome)' do
    expect(subject.format('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1612.0 Safari/537.36').uncolor).to eq('Chrome 31 (OS X 10.8)')
  end

  it 'handles UA string (IE)' do
    expect(subject.format('Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)').uncolor).to eq('Internet Explorer 10 (Windows 7)')
  end

  it 'handles UA string (Googlebot)' do
    expect(subject.format('Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)').uncolor).to eq('Googlebot/2.1')
  end
end
