module SqlSearchNSort
	#autoload :ActiveRecord, 'sql_search_n_sort/active_record'
	#autoload :SqlSearchableSortable, 'sql_search_n_sort/sql_searchable_sortable'
	require 'sql_search_n_sort/sql_searchable_sortable'
	require "factory_girl_rails" if Rails.env == 'test'
	require "pry"
	require "haml-rails"
end
