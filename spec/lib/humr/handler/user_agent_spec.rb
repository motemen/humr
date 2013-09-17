require 'spec_helper'
require 'humr/handler/user_agent'

describe Humr::Handler::UserAgent do
  subject(:handler) { Humr::Handler::UserAgent.new }

  include_examples 'humr_handler', :ua, Humr::Handler::UserAgent

  GOOD_CASES = [
    [
      'Chrome',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1612.0 Safari/537.36',
      'Chrome 31 (OS X 10.8)'
    ],
    [
      'IE',
      'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)',
      'Internet Explorer 10 (Windows 7)'
    ],
    [
      'Googlebot',
      'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',
      'Googlebot/2.1'
    ]
  ]

  GOOD_CASES.each do |tuple|
    name, full_ua, readable_ua = *tuple
    it "handles UA string (#{name})" do
      expect { |b| handler.replace(full_ua, &b) }.to yield_with_args(readable_ua)
    end
  end

  it 'ignores non-ua string' do
    expect { |b| handler.replace('foo bar baz', &b) }.not_to yield_control
  end

  it 'ignores non-ua string (HTTP request line)' do
    expect { |b| handler.replace('GET /foo/bar/1234 HTTP/1.0', &b) }.not_to yield_control
  end

  it 'handles unrecognized ua string' do
    expect { |b| handler.replace('Yeti/1.0 (NHN Corp.; http://help.naver.com/robots/)', &b) }.not_to yield_control
  end

  describe '#rough_version' do
    it 'rounds to first decimal point' do
      expect(handler.rough_version('7.2.3')).to eq('7.2')
    end

    it 'cuts off trailing zeros' do
      expect(handler.rough_version('7.0.0')).to eq('7')
    end
  end
end
