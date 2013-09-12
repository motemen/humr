module Humr
  module Splitter
    class LTSV
      Impl[:ltsv] = self

      def sub_each_field(line, &block)
        index = 0
        line.gsub(/([0-9A-Za-z_.-]+:)([^\t]+)/) do |field|
          index += 1
          "#{$1}#{yield($2, index)}"
        end
      end
    end
  end
end
