# -*- encoding: utf-8 -*-
require File.expand_path('../lib/activejson/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andy Caldwell"]
  gem.email         = ["andy.m.caldwell@googlemail.com"]
  gem.description   = %q{Simple template engine for JSON views}
  gem.summary       = %q{Simple template engine for JSON views}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "activejson"
  gem.require_paths = ["lib"]
  gem.version       = Activejson::VERSION

  gem.add_dependency "multi_json"
  gem.add_dependency "yajl-ruby"
end
