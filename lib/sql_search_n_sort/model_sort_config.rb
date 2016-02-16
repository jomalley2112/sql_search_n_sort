class ModelSortConfig < Array
		
	def initialize(*cols)

		cols.each do |col|
			if col.is_a? Hash
				opts_hash = col.fetch(col.keys.first)
				self << SortColumn.new(col.keys.first, opts_hash)
			else
				self << SortColumn.new(col)
			end
		end
	end

	def get_order(sort_by, dir, def_sort_col, base_class)
		if sort_column_obj = self.sortable_column(sort_by)
			# {sort_by => dir}
			ar_class = sort_column_obj.joined_table ? sort_column_obj.joined_table.to_s.classify.constantize : base_class
			ar_class.arel_table[sort_by].send(dir)
		else
			{def_sort_col => dir} if def_sort_col
		end
	end
 	
	def sortable_column(col)
		#returns nil if no matching sortable columns
		self.select { |model_sort_config| model_sort_config.send("column") == col.to_s }.first
	end

	def select_opts
		return self.inject([]) do |m, sort_col|
			m + sort_col.select_opts
		end 
	end
end