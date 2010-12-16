# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{yr}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marius Mathiesen"]
  s.date = %q{2010-12-16}
  s.description = %q{Gem to access Norwegian weather API yr.no}
  s.email = %q{marius (at) shortcut.no}
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "config/places.txt"]
  s.files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "lib/yr.rb", "lib/yr/version.rb", "lib/yr/detail.rb", "lib/yr/forecast.rb", "lib/yr/location.rb", "lib/yr/place.rb", "lib/yr/symbol.rb", "lib/yr/raw.rb", "lib/yr/wind.rb", "log/debug.log", "config/places.txt", "config/places.yml", "tasks/yr.rake"]
  s.homepage = %q{http://irbno.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{irbno}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Gem to access Norwegian weather API yr.no}
end
