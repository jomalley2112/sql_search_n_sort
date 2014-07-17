class Person < ActiveRecord::Base
	extend SqlSearchableSortable
	sql_searchable :first_name, :last_name
	sql_sortable 	 :first_name, :last_name, :email, :updated_at => {:show_asc => false, :display => "Date last changed"} #, :age
	
	default_sql_sort :last_name #TODO: Not working
end
