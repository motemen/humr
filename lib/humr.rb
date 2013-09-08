require 'strscan'

require 'humr/handler/url'
require 'humr/handler/si_prefix'
require 'humr/handler/time'
require 'humr/handler/user_agent'

module Humr
  class Runner
    def initialize(args)
      @args = args
      @handlers = [ Handler::URL.new, Handler::SIPrefix.new, Handler::Time.new, Handler::UserAgent.new ]
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
end
