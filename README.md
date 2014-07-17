# SqlSearchNSort #

## Not Quite Ready Yet ##

Provides very simple SQL-based sort and search functionality (that works together or separately) for the index or any other page that lists out ActiveRecord models without having to run a separate full-text server like Solr. Keep in mind that depending on your data volume and field types it may be wise to index some the fields you are searching or sorting on. Also, you will want to add your own CSS styles.

- Dependencies:
	- "rails", "~> 4.1.2"
  - "haml-rails"

- Development Environment Dependencies:
	- "sqlite3"
	- "rspec-rails"
	- "capybara"
	- "selenium-webdriver"
	- "factory_girl_rails"
	- "database_cleaner"
	- "faker"

- Usage: 
	1. Add to Gemfile: `gem "sql_search_n_sort", :git =>"https://github.com/jomalley2112/sql_search_n_sort.git"`
	then run `bundle install`
	2. In model to be searched/sorted add the following:
		- `extend SqlSearchableSortable`
		- `sql_searchable :searchable_col1, :searchable_col2, :searchable_col3 #...`
			- and/or
		- `sql_sortable :sortable_col1, :sortable_col2, :sortable_col3 => { show_desc: false, display: "Column Three"}, #...`
			- sql_sortable takes some optional hash option values: `show_asc: [true|false], show_desc: [true|false], display: "Column display text"`
		- and optionally
			-	`default_sql_sort :sortable_col1`
				- NOTE: specifying order in the model's default_scope will cause sql_sort functionality to break
	3. Views: 
		- In view file for page to include search functionality add the following code in the position where you want the search unit to be located: `= render 'search_form'`
		- In view file for page to include search functionality add the following code in the position where you want the sort unit to be located: `= render 'sort_form' #, :opts => @sort_dropdown_opts`
			-Note that the `:opts => @sort_dropdown_opts` is optional and may be included if you feel better about only using local variables in your partials or if for some reason you want to manually define your own set of options for the sort select list.
	4. In controller action (usually #index) add the following (assuming the model is named Person):
		- For both Search & Sort:
	  `@people = Person.sql_search(params[:search_for]).sql_sort(@sort_by, @sort_dir)`
		- For just Search
		`@people = Person.sql_search(params[:search_for])`
		- For just Sort:
		`@people = Person.sql_sort(@sort_by, @sort_dir)`
			- In app/controllers/application_controller.rb there will be a line: `before_filter :setup_sql_search_n_sort, :only => [:index]`. You will need to add any actions named anything other than :index to this array e.g. `before_filter :setup_sql_search_n_sort, :only => [:index, :other_action_using_sort]`. The other option is to completely remove the `:only` option altogether `before_filter :setup_sql_search_n_sort`, which may cause a minimal performance loss depending on how many actions are defined in your controller.
	5. Style to your liking


	Example Model:
	```
		class Person < ActiveRecord::Base
			extend SqlSearchableSortable
			sql_searchable :first_name, :last_name
			sql_sortable 	 :first_name, :last_name, :email, :updated_at => {:show_asc => false, :display => "Date last changed"}
			
			default_sql_sort :last_name #optional
			
			#NOTE: specifying order in your default_scope will cause sql_sort functionality to break
			#default_scope { order(:email) }
		end
	```

- FILES:
	- app/views/application/_sort_form.html.haml
	- app/views/application/_search_form.html.haml
	- app/assets/javascripts/sql_search_n_sort.js
	- Add method def to app/controllers/application_controller.rb
	- lib/sql_search_n_sort/sql_searchable_sortable.rb (does this need to be copied to models/concerns or is it
		just available because its in the lib dir of the gem???)
	- needs jquery if it isn't already required...use something like the following in the generator:
	```
	inject_into_file "#{::Rails.root.to_s}/app/assets/javascripts/application.js",
    before: "\n//= require_tree ." do
      "\n//= require jquery\n//= require jquery_ujs"
    end
  ```
TODO: In the form partials pass along ANY other params that exist
TODO: Add message when 0 search results...pull text from locale file
TODO: Allow for case-sensitive and whole word searches
TODO: Add image of top of list to this README if possible


This project uses MIT-LICENSE.