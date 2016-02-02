require 'rails/generators'
module SqlSearchNSort
	class InstallGenerator < Rails::Generators::Base

		source_paths << File.expand_path('../views/application', __FILE__)
		source_paths << File.expand_path('../assets/javascripts', __FILE__)
		source_paths << File.expand_path('../helpers', __FILE__)
		source_paths << File.expand_path('../config/initializers', __FILE__)

		def copy_files
			base_path = "app/views/application"
      copy_file('_search_form.html.haml', File.join(base_path, '_search_form.html.haml'))
      copy_file('_sort_form.html.haml', File.join(base_path, '_sort_form.html.haml'))

      base_path = "app/assets/javascripts"
      copy_file('sql_search_n_sort.js', File.join(base_path, 'sql_search_n_sort.js'))

      base_path = "config/initializers"
      copy_file('sql_search_n_sort.rb', File.join(base_path, 'sql_search_n_sort.rb'))
      
		end

		def require_jquery
			binding.pry
			# create_file "app/assets/javascripts/application.js" unless File.exists?("app/assets/javascripts/application.js")
			inject_into_file "app/assets/javascripts/application.js",
		    before: "\n//= require_tree ." do
		      "\n//= require jquery"
		    end
		end

		def insert_into_app_controller
			inject_into_file "app/controllers/application_controller.rb",
		    before: /^end/ do
		      %Q`\n\tinclude SqlSortSetup\n
	before_filter :setup_sql_sort, :only => [:index, :sort_only_index]
		   \n`
		    end
		end

	end
end