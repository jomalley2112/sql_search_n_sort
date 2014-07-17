module SqlSearchNSort
	require 'sql_search_n_sort/sql_searchable_sortable'
	require "factory_girl_rails" if Rails.env == 'test'
	require "pry"
	require "haml-rails"
	require "jquery-rails"
end
