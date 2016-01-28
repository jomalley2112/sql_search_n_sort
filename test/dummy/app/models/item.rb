class Item < ActiveRecord::Base
	extend SqlSearchableSortable
	sql_searchable :no_table
end