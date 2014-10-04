class Unsearchable < ActiveRecord::Base
	extend SqlSearchableSortable

	#sql_searchable :dt
end
