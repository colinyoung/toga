# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "toga/version"

Gem::Specification.new do |s|
  s.name        = "toga"
  s.version     = Toga::VERSION
  s.authors     = ["Colin Young"]
  s.email       = ["me@colinyoung.com"]
  s.homepage    = "https://github.com/colinyoung/toga"
  s.summary     = %q{a todo list that integrates seamlessly with git}
  s.description = %q{a todo list that integrates seamlessly with git}

  s.rubyforge_project = "toga"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "git"
  
  s.add_development_dependency 'require_relative'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'mocha'
end
