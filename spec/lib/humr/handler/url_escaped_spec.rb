# encoding: utf-8
require 'spec_helper'
require 'humr/handler/url_escaped'

describe Humr::Handler::URLEscaped do
  subject(:handler) { Humr::Handler::URLEscaped.new }

  include_examples 'humr_handler', :url, Humr::Handler::URLEscaped

  id = lambda { |x| x }

  it 'handles URL-escaped string' do
    expect { |b| handler.replace('/search?q=%E7%BE%8E%E9%A1%94%E5%99%A8', &b) }.to yield_with_args('美顔器')
    expect(handler.replace('/search?q=%E7%BE%8E%E9%A1%94%E5%99%A8', &id)).to eq('/search?q=美顔器')
  end

  it 'ignores non URL-escaped string' do
    expect { |b| handler.replace('/foo/bar/baz', &b) }.not_to yield_control
    expect(handler.replace('/foo/bar/baz', &id)).to be(nil)
  end
end
