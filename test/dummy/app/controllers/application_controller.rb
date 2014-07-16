class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :setup_sql_search_n_sort, :only => [:index]

  def setup_sql_search_n_sort
    model = controller_name.singularize.capitalize.constantize
    if model.is_a? SqlSearchableSortable
			if params[:sort_by]
				@sort_by = (params[:sort_by].split(' ').length > 1) ? params[:sort_by].split(' ').first.to_sym : params[:sort_by].to_sym
				dir = (params[:sort_by].split(' ').length > 1) ? params[:sort_by].split(' ')[1].to_sym : nil
				if [:asc, :desc].include?(dir)
					@sort_dir = dir
				else
					@sort_dir = :asc
					params[:sort_by] = @sort_by #attempt to save from invalid sort direction passed in with valid sort_by
				end
			else
				params[:sort_by] = Person.default_sort_col
			end

			@sort_dropdown_opts = model.sort_cols_for_dropdown #for the view
			#binding.pry
		end
  end
end
