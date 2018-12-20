require File.expand_path('../boot', __FILE__)

require 'rails/all'

#These are the only ones SSNS needs, but most projects will be using all of Rails probably
# require 'active_record/railtie'
# require 'sprockets/railtie'

Bundler.require(*Rails.groups)
require "sql_search_n_sort"

module Dummy
  class Application < Rails::Application
    
  end
end

