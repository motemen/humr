require 'humr/handler/url_escaped'
require 'humr/handler/si_prefix'
require 'humr/handler/time'
require 'humr/handler/user_agent'
require 'humr/splitter'

require 'optparse'
require 'term/ansicolor'

module Humr
  class Runner
    attr_reader :config

    def initialize(args)
      @args = args
      @config = Config.new
    end

    def self.bootstrap(args)
      new(args).run
    end

    def splitter
      @splitter ||= Splitter::Default.new
    end

    def handlers
      @handlers ||= config.handlers.map do |name|
        Handler[name].new
      end
    end

    def run
      should_colorize = true

      OptionParser.new do |opts|
        opts.on('-s', '--splitter SPLITTER[:ARGS]', 'Specify ield splitter (default, pattern:re, ltsv)') do |splitter|
          impl, *args = splitter.split(/:/, 2)
          @splitter = Splitter::Impl[impl.to_sym].new(*args)
        end
        opts.on('-c', '--[no-]color', "colorize output (default: true)") do |c|
          should_colorize = c
        end
      end.parse!(@args)

      STDIN.each_line do |line|
        puts readable_line(line.chomp, should_colorize)
      end
    end

    def readable_line(line, should_colorize)
      splitter.sub_each_field(line) do |field|
        readable_field(field, should_colorize)
      end
    end

    def readable_field(field, should_colorize)
      handlers.each do |handler|
        readable = handler.replace(field) do |chunk|
          should_colorize ? colorize(chunk, handler.name) : chunk
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
