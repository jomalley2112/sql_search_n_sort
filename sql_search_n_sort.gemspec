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

  s.add_dependency "nokogiri", '~> 1.10.4'
  # s.add_dependency "rails", '~> 5.1.4'
  s.add_dependency "activerecord", '~> 6.0'
  s.add_dependency "activesupport", '>= 6.0.3.1'
  s.add_dependency 'actionpack', '>= 6.0.3.2'
  s.add_dependency 'sprockets-rails'
  s.add_dependency "haml"
  s.add_dependency "jquery-rails", '~> 4.3.1'
  s.add_dependency 'loofah', '~> 2.3'
  s.add_dependency 'sprockets', '~> 3.7.2'
  s.add_dependency 'rubyzip', '~> 1.3.0'

  s.add_development_dependency "rspec-rails", '~> 3.8'
  s.add_development_dependency "factory_bot", '~> 5.1'
  s.add_development_dependency "database_cleaner", '~> 1.6.2'
  s.add_development_dependency "capybara", '~> 2.18'
  s.add_development_dependency "selenium-webdriver", '~> 3.11'
  s.add_development_dependency "equivalent-xml", '~> 0.6.0'
  s.add_development_dependency "ffi", '~> 1.9.24'
  s.add_development_dependency "rack", ">= 2.0.6"
  
end
