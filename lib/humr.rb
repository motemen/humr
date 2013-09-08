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
        puts readable_line(line.chomp)
      end
    end

    def readable_line(line)
      sub_each_field(line) do |s|
        human_readable s
      end
    end

    def sub_each_field(line, &block)
      scanner = ::StringScanner.new(line)

      result = ''
      loop do
        if s = scanner.scan(/".*?"|\[.*?\]/)
          result << s[0]
          result << yield(s[1..-2])
          result << s[-1]
        elsif s = scanner.scan(/\S+/)
          result << yield(s)
        elsif not scanner.eos?
          result << scanner.scan(/\s*/)
        else
          break
        end
      end

      result
    end

    def human_readable(s)
      @handlers.map do |handler|
        readable = handler.replace(s) do |chunk|
          colorize(chunk, handler.name)
        end
        return readable if readable
      end

      s
    end

    def colorize(s, name)
      s
    end
  end
end
