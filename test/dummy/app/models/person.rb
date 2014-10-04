class Person < ActiveRecord::Base
	extend SqlSearchableSortable
	
	#to be set from the sql_searchable method eventually
	#attr_accessor :ssns_sortable
	# def ssns_sortable(ssns_sortable)
	# 	@ssns_sortable = ssns_sortable
	# end

	sql_searchable :first_name, :last_name, :bio 
	sql_sortable 	 :first_name, :last_name, :email, 
		:updated_at => {:show_asc => false, :display => "Date last changed"}
	
	default_sql_sort :last_name
end
