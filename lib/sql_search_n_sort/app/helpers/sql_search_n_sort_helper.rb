module SqlSearchNSortHelper

	#Should only be used for forms performing a GET (which they all should be)
	def hide_current_params(*suppress)
		return "" if request.query_parameters.empty?
		suppress.concat(SqlSearchNSort.config.suppress_params[@mode] || [])
		request.query_parameters.reject { |k, v| suppress.include?(k) }.map do |k, v|
			hidden_field_tag(k, v, id: random_element_id)
		end.join("\n")
	end

	private

	def random_element_id
		# So we don't get elements with duplicate IDs in the page
		"generated-by-ssns_"+SecureRandom.hex(5)
	end

end