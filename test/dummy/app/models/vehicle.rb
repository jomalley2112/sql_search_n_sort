class Vehicle < ActiveRecord::Base
	extend SqlSearchableSortable
	
	sql_searchable  :manufacturer, :model, :engine
	sql_sortable 	 :year, :model, :color, :manufacturer => { :display_text => "Make" } 
	
	#No default sort column specified
end
	