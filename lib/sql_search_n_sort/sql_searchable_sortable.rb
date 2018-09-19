module SqlSearchableSortable

	#NOTES:
	#Comment.joins(:article).order(Article.arel_table[:headline]).to_sql=> "SELECT `comments`.* FROM `comments` INNER JOIN `articles` ON `articles`.`id` = `comments`.`article_id`  ORDER BY `articles`.`headline`"

  def self.extended(base)
  	base.class_eval do
  		attr_accessor :ssns_sortable
  		class << self
  			attr_accessor :default_sort_col, :default_sort_dir, :sql_search_cols, :sort_config
  		end

			#:Note remember when debugging from here "base" doesn't exist
			#These scopes get called on a model class from within an index action in a controller
			# ...like a class method
			scope :sql_search, ->(search_for="") do 
				search_for.blank? ? all : where(search_clause(search_for)) 
			end
			
			scope :sql_sort, ->(scope_sort_col=nil, scope_sort_dir=nil) do
				scope_sort_col ||= default_sort_col #use model's default sort col if no args present
				scope_sort_dir ||= default_sort_dir || :asc #same for direction
				order(sort_config.get_order(scope_sort_col, scope_sort_dir, default_sort_col, self))
			end
		end
  end

	def search_clause(search_for)
		(sql_search_cols || []).inject(nil) do |query, col|
			search_check = arel_table[col].matches("%#{sanitize_sql_like(search_for)}%")
			query.nil? ? search_check : query.or(search_check)
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


end
