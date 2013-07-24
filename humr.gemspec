Gem::Specification.new do |s|
  s.name     = 'humr'
  s.summary  = 'A CLI tool that make input human-readable'
  s.version  = '0.0.1'
  s.executables << 'humr'

  s.files = [
    'bin/humr',
    'lib/humr.rb'
  ]

  s.authors = [ 'motemen' ]
  s.email   = 'motemen@gmail.com'

  s.add_runtime_dependency 'term-ansicolor', '~> 1'

  s.license = 'MIT'
end
