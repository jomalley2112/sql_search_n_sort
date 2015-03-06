class Admin::Member < ActiveRecord::Base
	extend SqlSearchableSortable
	sql_searchable :first_name, :last_name
	sql_sortable 	 :first_name, :last_name, :email
end