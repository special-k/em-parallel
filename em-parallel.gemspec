Gem::Specification.new do |s|
  s.name = "em-parallel"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kirill Jakovlev"]
  s.date = "2013-09-11"
  s.description = "EM and Fiber based DSL for combining of parallel and successive operations"
  s.email = "special-k@li.ru"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = Dir['README', 'LICENSE.txt', 'lib/**/*', 'bin/**/*']
  s.homepage = "http://github.com/special-k/em-parallel"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "3.0.7"
  s.summary = "combining of parallel and successive operations"
  s.add_dependency "eventmachine"
  s.add_dependency "em-synchrony"
  s.add_development_dependency "rspec", "~> 2.8.0"
  s.add_development_dependency "yard", "~> 0.7"
  s.add_development_dependency "rdoc", "~> 3.12"
  s.add_development_dependency "bundler", "~> 1.0"
  s.add_development_dependency "jeweler", "~> 1.8.7"

end

