require 'simplecov'

SimpleCov.start

require 'term/ansicolor'

class String
  include Term::ANSIColor
end
