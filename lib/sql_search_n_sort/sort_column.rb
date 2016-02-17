class SortColumn
	attr_reader :column, :joined_table, :show_asc, :show_desc ,:display_text
	def initialize(column, opts={})
		@column       = column.to_s
		@joined_table = opts[:joined_table]
		@display_text = opts[:display_text] 
		@show_asc     = (opts[:show_asc].nil? ? true : opts[:show_asc])
		@show_desc    = (opts[:show_desc].nil? ? true : opts[:show_desc])
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