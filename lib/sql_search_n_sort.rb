module SqlSearchNSort
	require 'sql_search_n_sort/sort_column'
	require 'sql_search_n_sort/model_sort_config'
	require 'sql_search_n_sort/sql_searchable_sortable'
	require "sql_search_n_sort/sql_sort_setup"
	require 'sql_search_n_sort/railtie' if defined?(Rails)
	require 'sql_search_n_sort/exceptions'
	require "haml"
	require "jquery-rails"

	class Engine < Rails::Engine
	end

  def self.config(&block)
    yield Engine.config if block
    Engine.config
  end
end
