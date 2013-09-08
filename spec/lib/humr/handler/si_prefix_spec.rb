require 'spec_helper'
require 'humr/handler/si_prefix'

describe Humr::Handler::SIPrefix do
  subject(:handler) { Humr::Handler::SIPrefix.new }

  include_examples 'humr_handler', :si, Humr::Handler::SIPrefix

  it 'handles kilo' do
    expect { |b| handler.replace('1000', &b) }.to yield_with_args('1.0k')
  end

  it 'handles mega' do
    expect { |b| handler.replace((20 * 1000 * 1000).to_s, &b) }.to yield_with_args('20M')
  end

  it 'ignores non-numbers' do
    expect { |b| handler.replace('foobarbaz', &b) }.not_to yield_control
  end
end
