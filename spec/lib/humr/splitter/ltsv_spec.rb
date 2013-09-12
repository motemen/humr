require 'spec_helper'
require 'humr/splitter/ltsv'

describe Humr::Splitter::LTSV do
  subject(:splitter) { Humr::Splitter::LTSV.new }

  it 'calls block with field value and index' do
    expect { |b|
      splitter.sub_each_field %Q<host:127.0.0.1\tident:-\tuser:frank\ttime:[10/Oct/2000:13:55:36 -0700]\treq:GET /apache_pb.gif HTTP/1.0\tstatus:200\tsize:2326\treferer:http://www.example.com/start.html\tua:Mozilla/4.08 [en] (Win98; I ;Nav)> do |*args|
        b.to_proc.call(*args)
        ""
      end
    }.to yield_successive_args(
      *[
        '127.0.0.1',
        '-',
        'frank',
        '[10/Oct/2000:13:55:36 -0700]',
        'GET /apache_pb.gif HTTP/1.0',
        '200',
        '2326',
        'http://www.example.com/start.html',
        'Mozilla/4.08 [en] (Win98; I ;Nav)'
      ].unshift(nil).to_enum.each_with_index.to_a[1..-1]
    )
  end
end

