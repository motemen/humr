require 'spec_helper'
require 'humr/splitter/pattern'

describe Humr::Splitter::Pattern do
  subject(:splitter) { Humr::Splitter::Pattern.new('\t+') }

  it 'splits by specified pattern' do
    expect(
      splitter.sub_each_field("a\tbc\t\txyz") { |f,i| f.upcase }
    ).to eq("A\tBC\t\tXYZ")
  end

  it 'calls block with field value and index' do
    expect { |b|
      splitter.sub_each_field "a\tbc\t\txyz" do |*args|
        b.to_proc.call(*args)
        ""
      end
    }.to yield_successive_args(
      [ "a", 1 ],
      [ "bc", 2 ],
      [ "xyz", 3 ]
    )
  end
end
