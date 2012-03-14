require File.expand_path('../lib/omniauth-qq/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = "blankyao"
  gem.email         = "blankyao@gmail.com"
  gem.description   = %q{OmniAuth Oauth2 strategy for QQ.}
  gem.summary       = %q{OmniAuth Oauth2 strategy for QQ.}
  gem.homepage      = "https://github.com/blankyao/omniauth-qq"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-qq"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Qq::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.0'
end
