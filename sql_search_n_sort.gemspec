$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sql_search_n_sort/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sql_search_n_sort"
  s.version     = SqlSearchNSort::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SqlSearchNSort."
  s.description = "TODO: Description of SqlSearchNSort."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.2"

  s.add_development_dependency "sqlite3"
end
