module SqlSortSetup

	def setup_sql_sort
		binding.pry
		model = controller_name.singularize.capitalize.constantize
    if model.is_a? SqlSearchableSortable
			if params[:sort_by]
				@sort_by = (params[:sort_by].split(' ').length > 1) ? 
											params[:sort_by].split(' ').first.to_sym : params[:sort_by].to_sym
				dir = (params[:sort_by].split(' ').length > 1) ? params[:sort_by].split(' ')[1].to_sym : nil
				if [:asc, :desc].include?(dir)
					@sort_dir = dir
				else
					#attempt to save from invalid sort direction passed in with valid sort_by
					@sort_dir = :asc
					#TODO: I'm not sure its adviseable to set a params value like this
					params[:sort_by] = @sort_by 
				end
			else
				sort_by_param = model.default_sort_col.to_s
				sort_by_param += " #{model.default_sort_dir}" unless model.default_sort_dir.nil?
				#TODO: I'm not sure its adviseable to set a params value like this
				params[:sort_by] = sort_by_param
			end
			@sort_dropdown_opts = model.sort_cols_for_dropdown #for the view
			@sort_dir ||= :asc
		end
  end
end