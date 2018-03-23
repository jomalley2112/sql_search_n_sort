$:.push File.expand_path("../lib", __FILE__)

require "sql_search_n_sort/version"

Gem::Specification.new do |s|
  s.name        = "sql_search_n_sort"
  s.version     = SqlSearchNSort::VERSION
  s.authors     = ["John O'Malley"]
  s.email       = ["jom@nycap.rr.com"]
  s.homepage    = "https://github.com/jomalley2112/sql_search_n_sort"
  s.summary     = "Easily add search and sort functionality to list pages (e.g. index)"
  s.description = "A gem that allows for simple SQL-based search and sort functionality"
  s.license     = "MIT"

  s.files = Dir["lib/**/*", "MIT-LICENSE", "Rakefile"]
  # s.test_files = Dir["test/**/*"]

  s.add_dependency "nokogiri", '~> 1.8.1' #was 1.8.1
  s.add_dependency "rails", '~> 5.1.4' #was 5.1.4
  s.add_dependency "haml-rails", '~> 1.0.0'
  s.add_dependency "jquery-rails", '~> 4.3.1' #was 4.3.1
  s.add_dependency 'loofah', '~> 2.2.1'

  s.add_development_dependency "rspec-rails", '~> 3.7.2' #was 3.7.2
  s.add_development_dependency "factory_girl_rails", '~> 4.9.0' #was 4.9.0
  s.add_development_dependency "database_cleaner", '~> 1.6.2' #was 1.6.2
  s.add_development_dependency "capybara", '~> 2.18.0' #was 2.16.1
  s.add_development_dependency "selenium-webdriver", '~> 3.11.0' #was 3.7.0
  s.add_development_dependency "equivalent-xml", '~> 0.6.0' #was 0.6.0
  s.add_development_dependency "ffi", '~> 1.9.18' #was 1.9.18
  
  
end
