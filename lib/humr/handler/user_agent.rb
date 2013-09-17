require 'humr/handler'
require 'useragent'

module Humr
  class Handler::UserAgent < Handler
    register :ua

    def rough_version(s)
      s.sub(/(\d+\.\d+)(?:\.\d+)*/, '\1').sub(/\.0$/, '')
    end

    UA_LIKE_PATTERN = %r<^(?:[\w-]+(?:/[\w.-]+)?(?:\s*\([^\)]+\))?\s*)+$>

    def replace(s, &block)
      return unless UA_LIKE_PATTERN.match(s)

      ua = ::UserAgent.parse(s)

      return unless ua.version

      readable = if ua.bot?
        ua.os
      else
        '%s %s%s' % [
          ua.browser,
          rough_version(ua.version.to_s),
          if ua.os and not ua.os.empty?
            " (#{rough_version(ua.os)})"
          end
        ]
      end

      readable.sub(/.*/, &block) if readable
    end
  end
end
