Gem::Specification.new do |s|

  s.name = 'qticker'
  s.version = '1.0.5'
  s.date = '2016-09-19'
  s.summary = 'Quick Ticker: Enter a ticker symbol and get information.'
  s.description = 'This gem allows the user to enter a ticker symbol and retrieve a quote and company description.'
  s.license = 'MIT'
  s.homepage = 'https://github.com/lair001/qticker'
  s.authors = ['Samuel Lair']
  s.email = 'lair002@gmail.com'
  s.files = `git ls-files`.split(/\n/).keep_if{ |x| x.include?("lib/") || x.include?("config/") }
  s.executables   = ["qticker"]
  s.require_paths = ["config", "lib", "lib/fixtures"]

  s.required_ruby_version = ">= 2.3.0"

  s.add_dependency "nokogiri", "~>1.6", ">= 1.6.8"
  s.add_dependency "word_wrap", "~> 1.0"

  s.add_development_dependency "require_all", "~> 1.3", ">= 1.3.3"
  s.add_development_dependency "bundler", "~> 1.13", ">= 1.13.1"
  s.add_development_dependency "pry", "~> 0.10", ">= 0.10.4"
  s.add_development_dependency "rspec", "~> 3.5"

end
