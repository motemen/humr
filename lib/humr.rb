require 'uri'
require 'time'
require 'term/ansicolor'
require 'strscan'

module Humr
  class Runner
    def initialize(args)
      @args = args
      @handlers = [ Handler::URI.new, Handler::BinaryPrefix.new, Handler::Time.new ]
    end

    def self.bootstrap(args)
      new(args).run
    end

    def run
      STDIN.each_line do |line|
        scanner = ::StringScanner.new(line.chomp)
        readable = ''
        loop do
          if s = scanner.scan(/".*?"|\[.*?\]/)
            readable << s[0]
            readable << human_readable(s[1..-2])
            readable << s[-1]
          elsif s = scanner.scan(/\S+/)
            readable << human_readable(s)
          elsif not scanner.eos?
            readable << scanner.scan(/\s*/)
          else
            break
          end
        end
        puts readable
      end
    end

    def human_readable(s)
      for parser in @handlers
        readable = parser.format(s)
        return readable if readable
      end

      s
    end
  end

  class Handler
    def colorize(s)
      Term::ANSIColor.send(color, s)
    end

    class Time < self
      def parsers
        @parsers ||= [
          method(:_parse_apache_common_log_time),
          ::Time.method(:iso8601),
          ::Time.method(:httpdate),
          ::Time.method(:rfc822)
        ]
      end

      def color
        :yellow
      end

      def _parse_apache_common_log_time(s)
        ::Time.strptime(s, '%d/%b/%Y:%H:%M:%S %Z')
      end

      def parse(s)
        for parser in parsers
          parsed = parser[s] rescue nil
          return parsed if parsed
        end

        nil
      end

      def format(s)
        parsed = parse(s)
        colorize(parsed.to_s) if parsed
      end
    end

    class URI < self
      def color
        :green
      end

      def format(s)
        if /%[A-Fa-f0-9]{2}/ === s
          s.gsub(/((?:%[A-Fa-f0-9]{2})+)/) do |uri_escaped|
            colorize(::URI.unescape(uri_escaped))
          end
        end
      end
    end

    class BinaryPrefix < self
      PREFIXES = [ '' ] + %w(Ki Mi Gi Ti Pi Ei Zi Yi)

      def color
        :cyan
      end

      def base
        1024
      end

      def format(s)
        if /^\d{4,}$/ === s
          s.gsub(/(\d{4,})/) do |size|
            n = size.to_f
            i = 0
            while n > base and i < PREFIXES.length - 1
              n = n / base
              i = i + 1
            end
            colorize('%.1g%s' % [ n, PREFIXES[i] ])
          end
        end
      end
    end
  end

end
