require 'pry'
module SqlSearchableSortable
	extend ActiveSupport::Concern
 	
  def self.extended(base)
  	base.class_eval do
  		scope :sql_search, ->(search_for) { where(search_clause(search_for)) }
			scope :sql_sort, ->(sort_by, dir=:asc) do
				sort_by ||= @default_sort_col
				unscoped.order(sort_by => dir) if @sql_sort_cols.include?(sort_by) 
			end
		end
	end

	def search_clause(search_for)
		@sql_search_cols.inject("1=2 ") do |m, col|
			m << " or #{col} like '%#{search_for}%'"
		end
	end

	def sql_searchable(*cols)
		#attr_accessor :sql_search_cols
		@sql_search_cols = cols
			.select do |c| 
				col_name = c.is_a?(Hash) ? col.keys.first.to_s : c.to_s
				model_name.name.constantize.column_names.include?(col_name)
			end
	end

	def sql_sortable(*cols)
		#attr_accessor :sql_sort_cols #just add method if needed
		@sql_sort_cols = cols
	end

	def default_sql_sort(col)
		#attr_accessor :default_sort_col #just add method if needed
		@default_sort_col = col
	end

	#attribute reader
	def default_sort_col
		@default_sort_col
	end

#TODO: This looks like its got some kind of caching going on or something
	def sort_cols_for_dropdown
		# I believe we need an array of arrays for options_for_select()
		return @sql_sort_cols.inject([]) do |m, col|
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