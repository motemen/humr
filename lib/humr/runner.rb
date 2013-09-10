require 'humr/handler/url_escaped'
require 'humr/handler/si_prefix'
require 'humr/handler/time'
require 'humr/handler/user_agent'
require 'humr/splitter/default'

require 'term/ansicolor'
require 'strscan'

module Humr
  class Runner
    attr_reader :config, :splitter

    def initialize(*args)
      @args = args
      @config = Config.new
      @splitter = Splitter::Default.new
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
      splitter.sub_each_field(line) do |field|
        human_readable field
      end
    end

    def handlers
      @handlers ||= config.handlers.map do |name|
        Handler[name].new
      end
    end

    def human_readable(field)
      handlers.each do |handler|
        readable = handler.replace(field) do |chunk|
          colorize(chunk, handler.name)
        end
        return readable if readable
      end

      field
    end

    def colorize(chunk, handler)
      Term::ANSIColor.send(config.color(handler), chunk)
    end
  end
end
