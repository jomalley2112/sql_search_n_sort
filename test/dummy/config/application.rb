require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)
require "sql_search_n_sort"

module Dummy
  class Application < Rails::Application
    
  end
end

