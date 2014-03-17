Gem::Specification.new do |s|
  s.name    = 'filewatcher'
  s.version = '0.0.1'
  s.author  = 'Pepijn Looije'
  s.email   = 'pepijn@looije.me'
  s.description = s.summary = 'Get notified on file changes'
  s.homepage = 'https://github.com/pepijn/filewatcher'
  s.licenses = 'MIT'

  s.required_ruby_version = '>= 1.9'

  s.add_dependency 'pony'
  s.add_dependency 'letter_opener'

  s.add_development_dependency 'aruba'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- features/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end


