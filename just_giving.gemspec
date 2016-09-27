# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{just_giving}
  s.version = "0.2.0"

  s.authors = ['Thomas Pomfret']
  s.description = %q{A ruby wrapper for the justgiving.com API}
  s.email = 'thomas@mintdigital.com'
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.homepage = %q{http://github.com/mintdigital/just_giving}
  s.licenses = [%q{MIT}]
  s.require_paths = ["lib"]
  s.summary = %q{A ruby wrapper for the justgiving.com API}

  s.add_runtime_dependency 'faraday', '>= 0'
  s.add_runtime_dependency 'faraday_middleware', '>= 0'
  s.add_runtime_dependency 'hashie', '>= 0'
  s.add_runtime_dependency 'multi_json', '>= 1.0.1'
  s.add_runtime_dependency 'yajl-ruby', '>= 0'
  s.add_development_dependency "bundler", "~> 1.12"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency 'shoulda', '>= 0'
  s.add_development_dependency 'webmock', '>= 0'
end

