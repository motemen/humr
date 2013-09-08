require 'humr/handler'
require 'uri'

module Humr
  class Handler::URLEscaped < Handler
    register :url

    def replace(s, &block)
      if /%[A-Fa-f0-9]{2}/ === s
        s.gsub(/((?:%[A-Fa-f0-9]{2})+)/) do |url_escaped|
          yield URI.unescape(url_escaped)
        end
      end
    end
  end
end
