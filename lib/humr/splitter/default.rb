module Humr
  module Splitter
    class Default
      Impl[:default] = self

      PATTERN = /
        (?<s>")  (?<field>.*?) (?<e>") |
        (?<s>\[) (?<field>.*?) (?<e>\]) |
        (?<field>\S+)
      /x

      def sub_each_field(line, &block)
        index = 0
        line.gsub(PATTERN) do |m|
          index += 1
          [ $~['s'], yield($~['field'], index), $~['e'] ].join
        end
      end
    end
  end
end
