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

	In controller action (usually #index) you would add the following if the model was named Person:
	Search & Sort:
	`@people = Person.sql_search(params[:search_for]).sql_sort(@sort_by, (@sort_dir || :asc))`
	Only Sort:
	`@people = Person.sql_sort(@sort_by, (@sort_dir || :asc))`

	Example:
		class Person < ActiveRecord::Base
			extend SqlSearchableSortable
			sql_searchable :first_name, :last_name
			sql_sortable 	 :first_name, :last_name, :email, :updated_at => {:show_asc => false, :display => "Date last changed"}
			
			default_sql_sort :last_name
		end

	FILES:
		app/views/application/_sort_form.html.haml
		Add method def to app/controllers/application_controller.rb
		lib/sql_search_n_sort/sql_searchable_sortable.rb (does this need to be copied to models/concerns or is it
			just available because its in the lib dir of the gem???)

This project uses MIT-LICENSE.