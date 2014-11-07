module SqlSearchableSortable

  def self.extended(base)
  	base.class_eval do
  		attr_accessor :ssns_sortable
  		class << self
  			attr_accessor :default_sort_col, :default_sort_dir, :sql_sort_cols, :sql_search_cols
  		end

			#:Note remember when debugging from here "base" doesn't exist
			#These scopes get called on a model class from within an index action in a controller
			# ...like a class method
			scope :sql_search, ->(search_for) { where(search_clause(search_for)) }
			
			scope :sql_sort, ->(sort_by=nil, dir=nil) do
				sort_by ||= default_sort_col #use model's default sort col if no args present
				dir ||= default_sort_dir || :asc #same for direction
				if sql_sort_cols.any? { |c| c.is_a?(Hash) ? c.has_key?(sort_by) : c == sort_by }
					order(sort_by => dir)
				else
					default_sort_col ? order(default_sort_col => dir) : order(nil)
				end
			end
		end
	end

	def search_clause(search_for)
		(sql_search_cols || []).inject("1=2 ") do |m, col|
			m << " or #{col} like '%#{search_for}%'"
		end
	end

	def sql_searchable(*cols)
		self.sql_search_cols = (cols ||= [])
			.select do |c| 
				col_name = c.is_a?(Hash) ? col.keys.first.to_s : c.to_s
				#raise exception if not string or text type field
				raise(Exceptions::UnsearchableType.new(self, col_name)) \
					if ![:string, :text].include?(self.columns_hash[col_name].type)
				model_name.name.constantize.column_names.include?(col_name)
			end
	end

	def sql_sortable(*cols)
		self.sql_sort_cols = cols
	end

	def default_sql_sort(col, dir=nil)
		self.default_sort_col = col
		self.default_sort_dir = dir == :asc ? nil : dir
	end

	def sortable?
		!!sql_sort_cols
	end
	
	def sort_cols_for_dropdown
		sql_sort_cols = self.sql_sort_cols ||= []
		return sql_sort_cols.inject([]) do |m, col|
			if col.is_a?(Hash)
				h = col.fetch(col.keys.first)
				show_asc = h[:show_asc].nil? ? true : h[:show_asc]
				show_desc = h[:showdesc].nil? ? true : h[:show_desc]
				display_text = h[:display] || col.keys.first.to_s.humanize
				m << ["#{display_text}", "#{col.keys.first}"] if show_asc
				m << ["#{display_text} [desc]", "#{col.keys.first} desc"] if show_desc
			else
				m << [col.to_s.humanize, col.to_s]
				m << ["#{col.to_s.humanize} [desc]", "#{col} desc"]
			end 
			m
		end 
	end

end