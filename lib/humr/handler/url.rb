require 'humr/handler'
require 'uri'

module Humr
  class Handler::URL < Handler
    register :url

    def color
      :green
    end

    def format(s)
      if /%[A-Fa-f0-9]{2}/ === s
        s.gsub(/((?:%[A-Fa-f0-9]{2})+)/) do |uri_escaped|
          colorize(URI.unescape(uri_escaped))
        end
      end
    end
  end
end
