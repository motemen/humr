module Humr
  class Config
    DEFAULT = {
      :handlers => [
        :url, :si, :time, :ua
      ],
      :handler => {
        :url  => { :color => :green   },
        :si   => { :color => :cyan    },
        :time => { :color => :yellow  },
        :ua   => { :color => :magenta },
      }
    }

    COLORS = [
      :red,
      :green,
      :yellow,
      :blue,
      :magenta,
      :cyan
    ]

    def initialize
      @config = DEFAULT.dup
    end

    def handlers
      @config[:handlers].map(&:to_sym)
    end

    def color(handler)
      name = if handler.kind_of?(Symbol)
        handler
      else
        handler.name
      end

      @config[:handler][name][:color]
    end
  end
end
