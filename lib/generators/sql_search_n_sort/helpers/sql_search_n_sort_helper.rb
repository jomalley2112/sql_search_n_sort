module SqlSearchNSortHelper

	def hide_current_params(*suppress)
		puts "Check into the security risks of doing this"
		request.query_parameters.reject { |k, v| suppress.include?(k) }.map do |k, v|
			hidden_field_tag(k, v)
		end.join("\n")
	end

end