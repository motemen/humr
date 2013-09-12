require 'strscan'

module Humr
  module Splitter
    class Default
      Impl[:default] = self

      def sub_each_field(line, &block)
        scanner = StringScanner.new(line)

        result = ''
        index = 1

        loop do
          if s = scanner.scan(/".*?"|\[.*?\]/)
            result << s[0]
            result << yield(s[1..-2], index)
            result << s[-1]
            index += 1
          elsif s = scanner.scan(/\S+/)
            result << yield(s, index)
            index += 1
          elsif not scanner.eos?
            result << scanner.scan(/\s*/)
          else
            break
          end
        end

        result
      end
    end
  end
end
