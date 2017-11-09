module SqlSortSetup

	def setup_sql_sort(model_class=nil)
		#Get model class from class if passed in or by guessing at controller
		model = model_class || controller_name.classify.constantize 
    if model.is_a? SqlSearchableSortable
			if sort_by = get_sort_by(model) #so we just call the actual get_sort_by() method once
				@sort_by = (sort_by.split.length > 1) ? 
					sort_by.split.first.to_sym : sort_by.to_sym
				dir = (sort_by.split.length > 1) ? sort_by.split[1].to_sym : nil
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
				sort_by_param += " #{model.default_sort_dir}" if model.default_sort_dir
				#unless model.default_sort_dir.nil?
				params[:sort_by] = sort_by_param
			end
			@sort_dropdown_opts = model.sort_cols_for_dropdown #for the view
			@sort_dir ||= :asc
		end
  end

  private
  	
  	def init_sort_by_cookie
  		cookies[:sort_by] || '{"init": "init"}'
  	end

  	def get_sort_by(model)
  		sort_by =   params[:sort_by] 
  		sort_by	||= JSON.parse(init_sort_by_cookie)
  			.fetch(model.to_s, nil) #return cookie if it exists for current model's class
  		cookies[:sort_by] = JSON.generate({ model.to_s => sort_by })
  		cookies.each do |cookie|
			  puts "cookie=#{cookie[0]} cookie value=#{cookie[1]}"
			end
  		return sort_by
  	end
end

