# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{number_methods}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gavin Morrice"]
  s.date = %q{2009-09-13}
  s.description = %q{Grab or create factories for faster Functional/Integration testing}
  s.email = %q{gavin@handyrailstips.com}
  s.extra_rdoc_files = ["README.rdoc", "lib/grab.rb", "lib/number_methods.rb", "lib/spec/database_setup.rb", "lib/spec/dbfile", "lib/spec/factories.rb", "lib/spec/grab_spec.rb", "lib/spec/spec_helper.rb", "lib/spec/user.rb"]
  s.files = ["Manifest", "README.rdoc", "Rakefile", "factory_grabber.rb", "lib/grab.rb", "lib/number_methods.rb", "lib/spec/database_setup.rb", "lib/spec/dbfile", "lib/spec/factories.rb", "lib/spec/grab_spec.rb", "lib/spec/spec_helper.rb", "lib/spec/user.rb", "pkg/number_methods-0.1.0.gem", "pkg/number_methods-0.1.0.tar.gz", "pkg/number_methods-0.1.0/Manifest", "pkg/number_methods-0.1.0/README.rdoc", "pkg/number_methods-0.1.0/Rakefile", "pkg/number_methods-0.1.0/factory_grabber.rb", "pkg/number_methods-0.1.0/lib/grab.rb", "pkg/number_methods-0.1.0/lib/number_methods.rb", "pkg/number_methods-0.1.0/lib/spec/database_setup.rb", "pkg/number_methods-0.1.0/lib/spec/dbfile", "pkg/number_methods-0.1.0/lib/spec/factories.rb", "pkg/number_methods-0.1.0/lib/spec/grab_spec.rb", "pkg/number_methods-0.1.0/lib/spec/spec_helper.rb", "pkg/number_methods-0.1.0/lib/spec/user.rb", "pkg/number_methods-0.1.0/number_methods.gemspec", "number_methods.gemspec"]
  s.homepage = %q{http://github.com/gavinM/factory_grabber}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Number_methods", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{number_methods}
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
