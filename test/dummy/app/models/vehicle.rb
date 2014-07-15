class Vehicle < ActiveRecord::Base
	extend SqlSearchableSortable
	#Note ones we're passing in options to need to go at the end of the list
	sql_searchable :year, :manufacturer, :model, :engine, :color
	sql_sortable 	 :year, :model, :manufacturer => { :display => "Make" } 
	
end
	