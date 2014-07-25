class Vehicle < ActiveRecord::Base
	extend SqlSearchableSortable
	
	sql_searchable :year, :manufacturer, :model, :engine
	sql_sortable 	 :year, :model, :color, :manufacturer => { :display => "Make" } 
	
	#No default sort column specified
end
	