module SqlSortSetup

	def setup_sql_sort(model_class=nil)
		#Get model class from class if passed in or by guessing at controller
		model = model_class || controller_name.classify.constantize 
    if model.is_a? SqlSearchableSortable
			if @selected_sort_opt = sort_by = get_sort_by(model) #so we just call the actual get_sort_by() method once
				@sort_by = (sort_by.split.length > 1) ? 
					sort_by.split.first.to_sym : sort_by.to_sym
				dir = (sort_by.split.length > 1) ? sort_by.split[1].to_sym : nil
				if [:asc, :desc].include?(dir)
					@sort_dir = dir
				else
					@sort_dir = :asc
					params[:sort_by] = @sort_by 
				end
			else
				sort_by_param = model.default_sort_col.to_s
				sort_by_param += " #{model.default_sort_dir}" if model.default_sort_dir
				@selected_sort_opt = sort_by_param.gsub(/\sasc/i, "")
				params[:sort_by] = sort_by_param
			end
			@sort_dropdown_opts = model.sort_cols_for_dropdown
			@sort_dir ||= :asc
		end
  end

  private
  	
  	def push_or_replace_hash_element(key, val)
  		h = JSON.parse(cookies[:sort_by] || '{"init": "init"}')
  		h.merge!({key => val})
  	end
  	
  	def get_sort_by(model)
  		sort_by =   params[:sort_by]
  		sort_by ||=	JSON.parse(cookies[:sort_by]).fetch(model.to_s, nil) if cookies[:sort_by]
  		cookies[:sort_by] = JSON.generate(push_or_replace_hash_element(model.to_s, sort_by))
			return sort_by
  	end

end

