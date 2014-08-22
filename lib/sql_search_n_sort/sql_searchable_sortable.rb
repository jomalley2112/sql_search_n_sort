module SqlSearchableSortable
	extend ActiveSupport::Concern

  def self.extended(base)
  	base.class_eval do
  		attr_accessor :ssns_sortable
			
			#:Note remember when debugging from here "base" doesn't exist
			scope :sql_search, ->(search_for) { where(search_clause(search_for)) }
			
			scope :sql_sort, ->(sort_by=nil, dir=nil) do
				sort_by ||= self.class_variable_get(:@@default_sort_col)
				dir ||= self.class_variable_get(:@@default_sort_dir) || :asc
				#This takes care of not only column names as symbols but also 
				# as keys of hashes passed to sql_searchable
				if  self.class_variable_get(:@@sql_sort_cols).any? { |c| c.is_a?(Hash) ? c.has_key?(sort_by) : c == sort_by }
					order(sort_by => dir)
				else
					default_sort_col ? order(default_sort_col => dir) : order(nil)
				end
			end
		end
	end

	def search_clause(search_for)
		(self.class_variable_get(:@@sql_search_cols) || []).inject("1=2 ") do |m, col|
			m << " or #{col} like '%#{search_for}%'"
		end
	end

	def sql_searchable(*cols)
		self.class_variable_set(:@@sql_search_cols, (cols ||= []))
			.select do |c| 
				col_name = c.is_a?(Hash) ? col.keys.first.to_s : c.to_s
				model_name.name.constantize.column_names.include?(col_name)
			end
	end

	def sql_sortable(*cols)
		#to ensure @@default_sort_col & @@default_sort_dir get initialized
		# when no default column is specified for the model we just call default_sql_sort(nil)
		default_sql_sort(nil)
		self.class_variable_set(:@@sql_sort_cols, cols)
	end

	def default_sql_sort(col, dir=nil)
		self.class_variable_set(:@@default_sort_col, col)
		dir = nil if dir == :asc
		self.class_variable_set(:@@default_sort_dir, dir)
	end

	def sortable?
		!!self.class_variable_get(:@@sql_sort_cols)
	end

	#attribute reader
	def default_sort_col
		self.class_variable_get(:@@default_sort_col)
	end

	#attribute reader
	def default_sort_dir
		self.class_variable_get(:@@default_sort_dir)
	end

	
	def sort_cols_for_dropdown
		sql_sort_cols = self.class_variable_get(:@@sql_sort_cols)
		sql_sort_cols ||= []
		return sql_sort_cols.inject([]) do |m, col|
			if col.is_a?(Hash) 
				h = col.fetch(col.keys.first)
				show_asc = h[:show_asc].nil? ? true : h[:show_asc]
				show_desc = h[:showdesc].nil? ? true : h[:show_desc]
				display_text = h[:display] || col.keys.first.to_s.humanize
				m << [display_text, col.keys.first.to_s] if show_asc
				m << ["#{display_text} [desc]", "#{col.keys.first} desc"] if show_desc
			else
				m << [col.to_s.humanize, col.to_s]
				m << ["#{col.to_s.humanize} [desc]", "#{col} desc"]
			end 
			m
		end 
	end

end