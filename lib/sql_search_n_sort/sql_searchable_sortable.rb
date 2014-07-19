#require 'pry'
module SqlSearchableSortable
	extend ActiveSupport::Concern
 	
  def self.extended(base)
  	base.class_eval do
  		scope :sql_search, ->(search_for) { where(search_clause(search_for)) }
			scope :sql_sort, ->(sort_by, dir=:asc) do
				sort_by ||= @default_sort_col
				#This takes care of not only column names as symbols but also as keys of hashes passed to sql_searchable
				if  @sql_sort_cols.any? { |c| c.is_a?(Hash) ? c.has_key?(sort_by) : c == sort_by }
					order(sort_by => dir)
				else
					unscoped.order(default_sort_col => dir)
				end
			end
		end
	end

	def search_clause(search_for)
		@sql_search_cols.inject("1=2 ") do |m, col|
			m << " or #{col} like '%#{search_for}%'"
		end
	end

	def sql_searchable(*cols)
		@sql_search_cols = cols || []
			.select do |c| 
				col_name = c.is_a?(Hash) ? col.keys.first.to_s : c.to_s
				model_name.name.constantize.column_names.include?(col_name)
			end
	end

	def sql_sortable(*cols)
		@sql_sort_cols = cols
	end

	def default_sql_sort(col)
		@default_sort_col = col
	end

	#attribute reader
	def default_sort_col
		@default_sort_col
	end

	#maybe skip this if model not sortable
	def sort_cols_for_dropdown
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