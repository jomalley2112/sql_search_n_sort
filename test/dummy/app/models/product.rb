class Product < ActiveRecord::Base

	extend SqlSearchableSortable

	sql_sortable :name, :manufacturer,  :price

	default_sql_sort :manufacturer, :desc

end
