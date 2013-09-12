require 'strscan'

module Humr
  module Splitter
    class Pattern
      Impl[:pattern] = self

      def initialize(pattern)
        @pattern = Regexp.new(pattern)
        @pattern_la = Regexp.new("(?=#{pattern})")
      end

      def sub_each_field(line, &block)
        scanner = StringScanner.new(line)

        result = ''
        index = 1

        loop do
          field = scanner.scan_until(@pattern_la)
          if field
            result << yield(field, index)
            result << scanner.scan(@pattern)
            index += 1
          else
            result << yield(scanner.rest, index)
            break
          end
        end

        result
      end
    end
  end
end
