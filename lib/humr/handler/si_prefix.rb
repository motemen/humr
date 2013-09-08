require 'humr/handler'

module Humr
  class Handler::SIPrefix < Handler
    register :si

    PREFIXES = [ '' ] + %w(k M G T P E Z Y)

    def color
      :cyan
    end

    def base
      1000
    end

    def format(s)
      if /^\d{4,}$/ === s
        s.gsub(/(\d{4,})/) do |size|
          n = size.to_f
          i = 0
          while n >= base and i < PREFIXES.length - 1
            n = n / base
            i = i + 1
          end
          if n < 10
            colorize('%.1f%s' % [ n, PREFIXES[i] ])
          else
            colorize('%d%s' % [ n, PREFIXES[i] ])
          end
        end
      end
    end
  end
end
