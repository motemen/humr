require 'term/ansicolor'

module Humr
  class Handler
    def self.handlers
      @@handlers ||= {}
    end

    def self.register(name)
      handlers[name] = self
    end

    def colorize(s)
      Term::ANSIColor.send(color, s)
    end
  end
end
