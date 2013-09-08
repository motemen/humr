require 'spec_helper'
require 'humr'

describe Humr::Runner do
  subject { Humr::Runner.new(nil) }

  describe '#readable_line' do
    it 'handles accesslog' do
      expect(subject.readable_line(<<-INPUT)).to eq(<<-READABLE)
        66.249.66.33 - - [08/Sep/2013:04:33:45 +0900] "GET /randompoku/?%E3%82%AF%E3%83%83%E3%82%AF%E3%83%91%E3%83%83%E3%83%89 HTTP/1.1" 200 4710 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
      INPUT
        66.249.66.33 - - [#{'2013-09-08 04:33:45 +0900'.color(:yellow)}] "GET /randompoku/?#{'クックパッド'.color(:green)} HTTP/1.1" 200 #{'4.7k'.color(:cyan)} "-" "#{'Googlebot/2.1'.color(:magenta)}"
      READABLE
    end
  end
end
