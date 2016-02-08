class Item < ActiveRecord::Base
	extend SqlSearchableSortable
	sql_searchable :name, :descr
	sql_sortable :name, :descr
end