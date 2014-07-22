# SqlSearchNSort #

[![Gem Version](https://badge.fury.io/rb/sql_search_n_sort.svg)](http://badge.fury.io/rb/sql_search_n_sort)

Provides very simple SQL-based search and sort functionality (that works together or separately) for the index or any other page that lists out ActiveRecord models without having to run a separate full-text server like Solr. Keep in mind that depending on your data volume and field types it may be wise to index some or all of the fields you are searching or sorting on. Also, you will want to add your own CSS styles.


![Screenshot](/readme_assets/ssns_scrshot.png?raw=true "Screenshot of gem at work.")

- Usage: 
	1. Add to Gemfile: `gem "sql_search_n_sort"` then run `bundle install`
	2. Run `rails g sql_search_n_sort:install`
	3. In model to be searched/sorted add the following:
		- `extend SqlSearchableSortable`
		- `sql_searchable :searchable_col1, :searchable_col2, :searchable_col3 #...`
			- and/or
		- `sql_sortable :sortable_col1, :sortable_col2, :sortable_col3 => { show_desc: false, display: "Column Three"}, #...`
			- sql_sortable takes some optional hash option values: 
				- `show_asc: [true|false]` - Should the Sort by dropdown have an option for sorting by this column in ascending order?
				- `show_desc: [true|false]` - Should the Sort by dropdown have an option for sorting by this column in descending order? 
				- `display: "Column display text"` - The text displayed for this column in the Sort by dropdown.
		- and optionally you can specify the default ordering column in the model file
			-	`default_sql_sort :sortable_col1`
				- NOTE: specifying order in the model's default_scope will cause sql_sort functionality to break
	4. Views: 
		- In view file for page to include search functionality add the following code in the position where you want the search unit to be located: `= render 'search_form'`
		- In view file for page to include search functionality add the following code in the position where you want the sort unit to be located: `= render 'sort_form' #, :opts => @sort_dropdown_opts`
			- Note that the `:opts => @sort_dropdown_opts` is optional and may be included if you feel better about only using local variables in your partials or if for some reason you want to manually define your own set of options for the sort select list (not recommended).
	5. In the controller action (usually #index) add the following (assuming in this case the model is named Person):
		- For just Search
		`@people = Person.sql_search(params[:search_for])`
		- For just Sort:
		`@people = Person.sql_sort(@sort_by, @sort_dir)`
		- For both Search & Sort:
	  `@people = Person.sql_search(params[:search_for]).sql_sort(@sort_by, @sort_dir)`
			- In app/controllers/application_controller.rb there will be a line: `before_filter :setup_sql_sort, :only => [:index, :sort_only_index]`. You will need to add any actions named anything other than :index to this array and most likely remove :sort_only_index e.g. `before_filter :setup_sql_sort, :only => [:index, :other_action_using_sort]`. The other option is to completely remove the `:only` option altogether `before_filter :setup_sql_sort`, which could cause a minimal performance loss depending on how many actions are defined in your controller.
	6. Style to your liking


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

- Files that will be copied to your project:
	- `app/views/application/_sort_form.html.haml`
	- `app/views/application/_search_form.html.haml`
	- `app/assets/javascripts/sql_search_n_sort.js`
	- `app/helpers/sql_search_n_sort_helper.rb`
- Other changes made by the generator
	- Adds an include and a before_filter call to `app/controllers/application_controller.rb`
	- Adds `//= require jquery` to app/assets/javascripts/application.js if not already there.
	
- Dependencies:
	- "rails", "~> 4.0"
  - "haml-rails"

- Development Environment Dependencies:
	- "sqlite3"
	- "rspec-rails"
	- "capybara"
	- "selenium-webdriver"
	- "factory_girl_rails"
	- "database_cleaner"
	- "faker"

TODO: Allow for case-sensitive and whole word searches


This project uses MIT-LICENSE.