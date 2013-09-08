require 'humr/handler'
require 'time'

module Humr
  class Handler::Time < Handler
    register :time

    def color
      :yellow
    end

    def parsers
      @parsers ||= [
        method(:_apache_common_log_time),
        method(:_ctime),
        ::Time.method(:iso8601),
        ::Time.method(:httpdate),
        ::Time.method(:rfc822)
      ]
    end

    def _apache_common_log_time(s)
      ::Time.strptime(s, '%d/%b/%Y:%H:%M:%S %Z')
    end

    def _ctime(s)
      ::Time.strptime(s, '%c')
    end

    def parse(s)
      for parser in parsers
        parsed = parser[s] rescue nil
        return parsed if parsed
      end

      nil
    end

    def format(s)
      parsed = parse(s)
      colorize(parsed.to_s) if parsed
    end
  end
end
