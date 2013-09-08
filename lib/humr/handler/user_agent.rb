require 'humr/handler'
require 'useragent'

module Humr
  class Handler::UserAgent < Handler
    register :ua

    def color
      :magenta
    end

    def rough_version(s)
      s.sub(/(\d+\.\d+)(?:\.\d+)*/, '\1').sub(/\.0$/, '')
    end

    def format(s)
      return nil unless %r<^(?:[\w-]+(?:/[\w.-]+)?(?:\s*\([^\)]+\))?\s*)+$>.match(s)

      ua = ::UserAgent.parse(s)

      return nil unless ua.version

      return colorize(ua.os) if ua.bot?

      colorize('%s %s%s' % [ ua.browser, rough_version(ua.version.to_s), if ua.os and not ua.os.empty? then " (#{rough_version(ua.os)})" end ])
    end
  end
end
