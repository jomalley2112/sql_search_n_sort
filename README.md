# SqlSearchNSort #

## Still under construction and not ready yet! ##

Usage: 
	Add to Gemfile: `gem "sql_search_n_sort", :git =>"https://github.com/jomalley2112/sql_search_n_sort.git"`
	then run `bundle install`
	In model to be searched/sorted add the following:
	`sql_searchable :searchable_col1, :searchable_col2, :searchable_col3 #...`
	`sql_sortable :sortable_col1, :sortable_col2, :sortable_col3 #...`
	In view file for page to include search functionality add the following code in the position where you want the search input to be located: `= render 'sql search'`

	In view file for page to include search functionality add the following code in the position where you want the sort select to be located: `= render 'sql_sort'`

	In controller action (usually #index) you would add the following if we  the model was named Person:
	`@people = Person.sql_search(params[:search_for]).sql_sort(params[:sort_by])`

This project uses MIT-LICENSE.