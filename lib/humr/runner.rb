require 'humr/handler/url_escaped'
require 'humr/handler/si_prefix'
require 'humr/handler/time'
require 'humr/handler/user_agent'

require 'term/ansicolor'
require 'strscan'

module Humr
  class Runner
    attr_reader :config

    def initialize(*args)
      @args = args
      @config = Config.new
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

    def handlers
      @handlers ||= config.handlers.map do |name|
        Handler[name].new
      end
    end

    def human_readable(s)
      handlers.each do |handler|
        readable = handler.replace(s) do |chunk|
          colorize(chunk, handler.name)
        end
        return readable if readable
      end

      s
    end

    def colorize(chunk, handler)
      Term::ANSIColor.send(config.color(handler), chunk)
    end
  end
end
