require 'term/ansicolor'

module Humr
  class Handler
    def self.handlers
      @@handlers ||= {}
    end

    def self.register(name)
      @@name = name
      handlers[name] = self
    end

    def name
      @@name
    end

    def colorize(s)
      Term::ANSIColor.send(color, s)
    end

    def format(s)
      replace(s) { |s| colorize(s) }
    end
  end
end
