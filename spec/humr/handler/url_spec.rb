require 'spec_helper'
require 'humr/handler/url'

describe Humr::Handler::URL do
  subject { Humr::Handler::URL.new }

  it 'is registered as :url' do
    expect(Humr::Handler[:url]).to be(Humr::Handler::URL)
  end

  it 'parses URL-escaped string' do
    expect(subject.format('/search?q=%E7%BE%8E%E9%A1%94%E5%99%A8').uncolor).to eq('/search?q=美顔器')
  end

  it 'ignores non URL-escaped string' do
    expect(subject.format('/foo/bar/baz')).to be(nil)
  end
end
