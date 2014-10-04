module SqlSearchNSort
	require 'sql_search_n_sort/sql_searchable_sortable'
	require "sql_search_n_sort/sql_sort_setup"
	require 'sql_search_n_sort/railtie' if defined?(Rails)
	require 'sql_search_n_sort/exceptions'
	require "factory_girl_rails" if Rails.env == 'test'
	require "haml-rails"
	require "jquery-rails"
end
