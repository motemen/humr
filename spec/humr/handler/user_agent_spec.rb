require 'spec_helper'
require 'humr/handler/user_agent'

describe Humr::Handler::UserAgent do
  subject { Humr::Handler::UserAgent.new }

  it 'is registered as :ua' do
    expect(Humr::Handler.handlers[:ua]).to be(Humr::Handler::UserAgent)
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

  it 'ignores non-ua string' do
    expect(subject.format('foo bar baz')).to be(nil)
  end

  it 'ignores non-ua string (HTTP request line)' do
    expect(subject.format('GET /foo/bar/1234 HTTP/1.0')).to be(nil)
  end
end
