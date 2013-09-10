require 'spec_helper'
require 'humr/splitter/default'

describe Humr::Splitter::Default do
  subject(:splitter) { Humr::Splitter::Default.new }

  it 'calls block with field value and index' do
    expect { |b|
      splitter.sub_each_field %q<66.249.66.33 - - [08/Sep/2013:04:33:45 +0900] "GET /randompoku/?%E3%82%AF%E3%83%83%E3%82%AF%E3%83%91%E3%83%83%E3%83%89 HTTP/1.1" 200 4710 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"> do |*args|
        b.to_proc.call(*args)
        ""
      end
    }.to yield_successive_args(
      *[
        '66.249.66.33',
        '-',
        '-',
        '08/Sep/2013:04:33:45 +0900',
        'GET /randompoku/?%E3%82%AF%E3%83%83%E3%82%AF%E3%83%91%E3%83%83%E3%83%89 HTTP/1.1',
        '200',
        '4710',
        '-',
        'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)'
      ].unshift(nil).to_enum.each_with_index.to_a[1..-1]
    )
  end
end
