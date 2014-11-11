module SqlSearchableSortable

  def self.extended(base)
  	base.class_eval do
  		attr_accessor :ssns_sortable
  		class << self
  			attr_accessor :default_sort_col, :default_sort_dir, :sql_search_cols, :sort_config
  		end

			#:Note remember when debugging from here "base" doesn't exist
			#These scopes get called on a model class from within an index action in a controller
			# ...like a class method
			scope :sql_search, ->(search_for) { where(search_clause(search_for)) }
			
			scope :sql_sort, ->(scope_sort_col=nil, scope_sort_dir=nil) do
				scope_sort_col ||= default_sort_col #use model's default sort col if no args present
				scope_sort_dir ||= default_sort_dir || :asc #same for direction
				order(sort_config.get_order(scope_sort_col, scope_sort_dir, default_sort_col))
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
		self.sort_config = ModelSortConfig.new(*cols)
	end

	def default_sql_sort(col, dir=nil)
		self.default_sort_col = col
		self.default_sort_dir = dir == :asc ? nil : dir
	end

	def sortable?
		!!sort_config
	end
	
	def sort_cols_for_dropdown
		sort_config.select_opts 
	end

	class ModelSortConfig < Array
		
		def initialize(*cols)
			cols.each do |col|
				if col.is_a? Hash
					h = col.fetch(col.keys.first)
					self << SortColumn.new(col.keys.first, h[:display_text], h.fetch(:show_asc, true), h.fetch(:show_desc, true))
				else
					self << SortColumn.new(col)
				end
			end
		end

		def get_order(sort_by, dir, def_sort_col)
			if self.contains_column(sort_by)
				{sort_by => dir}
			else
				{def_sort_col => dir} if def_sort_col
			end
		end
	 	
		def contains_column(col)
			self.any? { |sc| sc.column == col }
		end

		def select_opts
			return self.inject([]) do |m, sort_col|
				m + sort_col.select_opts
			end 
		end
	end
	
	class SortColumn
		attr_reader :column, :show_asc, :show_desc ,:display_text
		def initialize(column, display_text=nil, show_asc=true, show_desc=true)
			@column = column
			@display_text = display_text
			@show_asc = show_asc
			@show_desc = show_desc
		end
		def name
			column.to_s
		end
		def human_name
			name.humanize
		end
		def select_opts
			arr = []
			arr << ["#{display_text || human_name}",        "#{name}"]      if show_asc
			arr << ["#{display_text || human_name} [desc]", "#{name} desc"] if show_desc
			return arr
		end
	end

end
