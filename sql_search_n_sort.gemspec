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

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'nokogiri', '=1.6.3.1'
  s.add_dependency "rails", "~> 4.0"
  s.add_dependency 'mysql2', '~> 0.3.18'
  s.add_dependency "haml-rails"
  s.add_dependency 'jquery-rails'


  # s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "pry"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "capybara"
  s.add_development_dependency "selenium-webdriver"
  s.add_development_dependency "chromedriver-helper"
  s.add_development_dependency "faker"
  s.add_development_dependency "equivalent-xml"
  
  
end
