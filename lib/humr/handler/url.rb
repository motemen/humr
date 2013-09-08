require 'humr/handler'
require 'uri'

module Humr
  class Handler::URL < Handler
    register :url

    def color
      :green
    end

    def replace(s, &block)
      if /%[A-Fa-f0-9]{2}/ === s
        s.gsub(/((?:%[A-Fa-f0-9]{2})+)/) do |uri_escaped|
          yield URI.unescape(uri_escaped)
        end
      end
    end
  end
end
