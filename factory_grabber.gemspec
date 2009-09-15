# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{factory_grabber}
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gavin Morrice"]
  s.date = %q{2009-09-15}
  s.description = %q{Grab or create factories for faster Functional/Integration testing}
  s.email = %q{gavin@handyrailstips.com}
  s.extra_rdoc_files = ["CHANGELOG", "README.md", "lib/dbfile", "lib/factory_grabber.rb", "lib/spec/database_setup.rb", "lib/spec/dbfile", "lib/spec/factories.rb", "lib/spec/grab_spec.rb", "lib/spec/performance_test.rb", "lib/spec/spec_helper.rb", "lib/spec/user.rb"]
  s.files = ["CHANGELOG", "Manifest", "README.md", "Rakefile", "factory_grabber.gemspec", "init.rb", "lib/dbfile", "lib/factory_grabber.rb", "lib/spec/database_setup.rb", "lib/spec/dbfile", "lib/spec/factories.rb", "lib/spec/grab_spec.rb", "lib/spec/performance_test.rb", "lib/spec/spec_helper.rb", "lib/spec/user.rb"]
  s.homepage = %q{http://github.com/gavinM/factory_grabber}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Factory_grabber", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{factory_grabber}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Grab or create factories for faster Functional/Integration testing}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end