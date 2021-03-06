
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gp_common_logic/version'

Gem::Specification.new do |spec|
  spec.name          = 'gp_common_logic'
  spec.version       = GpCommonLogic::VERSION
  spec.authors       = ['Oleg Popkov']
  spec.email         = ['amik0amik0@gmail.com']

  spec.summary       = %q{GP Common Logic}
  spec.description   = %q{Common logic for GP projects}
  spec.homepage      = 'https://github.com/amik0/gp_common_logic'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'railties'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'combustion'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'activerecord', '>= 4.2'
end
