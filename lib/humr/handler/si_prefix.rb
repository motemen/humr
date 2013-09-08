require 'humr/handler'

module Humr
  class Handler::SIPrefix < Handler
    register :si

    PREFIXES = [ '' ] + %w(k M G T P E Z Y)

    def base
      1000
    end

    def replace(s, &block)
      if /^\d{4,}$/ === s
        s.gsub(/(\d{4,})/) do |size|
          n = size.to_f
          i = 0
          while n >= base and i < PREFIXES.length - 1
            n = n / base
            i = i + 1
          end

          format = if n < 10
            '%.1f%s'
          else
            '%d%s'
          end

          yield format % [ n, PREFIXES[i] ]
        end
      end
    end
  end
end
