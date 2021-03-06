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
			#could be either application.js or application.js.coffee or maybe something else in the future
			if app_js_fl = Dir["#{destination_root}/app/assets/javascripts/*"].select{|f| f =~ /application\.js/}.first
				inject_into_file app_js_fl,
		    before: "\n//= require_tree ." do
		      "\n//= require jquery"
		    end
			end
		end

		def insert_into_app_controller
			inject_into_file "app/controllers/application_controller.rb",
		    before: /^end/ do
		      %Q`\n\tinclude SqlSortSetup\n
	before_action :setup_sql_sort, :only => [:index, :sort_only_index]
		   \n`
		    end
		end

	end
end