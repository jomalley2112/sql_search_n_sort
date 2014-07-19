require 'rails/generators'
module SqlSearchNSort
	class InstallGenerator < Rails::Generators::Base
		puts "Inside Generator"

		source_paths << File.expand_path('../views/application', __FILE__)
		source_paths << File.expand_path('../assets/javascripts', __FILE__)
		source_paths << File.expand_path('../helpers', __FILE__)

		def copy_files
			#binding.pry
			base_path = "app/views/application"
      copy_file('_search_form.html.haml', File.join(base_path, '_search_form.html.haml'))
      copy_file('_sort_form.html.haml', File.join(base_path, '_sort_form.html.haml'))

      base_path = "app/assets/javascripts"
      copy_file('sql_search_n_sort.js', File.join(base_path, 'sql_search_n_sort.js'))

      base_path = "app/helpers"
      copy_file('sql_search_n_sort_helper.rb', File.join(base_path, 'sql_search_n_sort_helper.rb'))
      
		end

		def require_jquery
			inject_into_file "app/assets/javascripts/application.js",
		    before: "\n//= require_tree ." do
		      "\n//= require jquery"
		    end
		end

		def insert_into_app_controller
			inject_into_file "app/controllers/application_controller.rb",
		    before: /^end/ do
		      %Q`\n  before_filter :setup_sql_search_n_sort, :only => [:index, :sort_only_index]

  def setup_sql_search_n_sort
    model = controller_name.singularize.capitalize.constantize
    if model.is_a? SqlSearchableSortable
			if params[:sort_by]
				@sort_by = (params[:sort_by].split(' ').length > 1) ? 
											params[:sort_by].split(' ').first.to_sym : params[:sort_by].to_sym
				dir = (params[:sort_by].split(' ').length > 1) ? params[:sort_by].split(' ')[1].to_sym : nil
				if [:asc, :desc].include?(dir)
					@sort_dir = dir
				else
					@sort_dir = :asc
					params[:sort_by] = @sort_by #attempt to save from invalid sort direction passed in with valid sort_by
				end
			else
				params[:sort_by] = model.default_sort_col
			end
			@sort_dropdown_opts = model.sort_cols_for_dropdown #defined for the view to use
			@sort_dir ||= :asc
		end
  end\n\n`
		    end
		end



	end
end