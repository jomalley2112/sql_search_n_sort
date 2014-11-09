class Article < ActiveRecord::Base
	extend SqlSearchableSortable

	sql_sortable :by_line, :headline, :body, :date_pub => { display_text: "Date Published" }

	default_sql_sort :date_pub, :asc
end
