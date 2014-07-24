class VehiclesController < ApplicationController

	def index
		#binding.pry
		@vehicles = Vehicle.sql_search(params[:search_for]).sql_sort(@sort_by, @sort_dir)
	end

	def search_only_index
		@vehicles = Vehicle.sql_search(params[:search_for])
	end

	def sort_only_index
		@vehicles = Vehicle.sql_sort(@sort_by, (@sort_dir))
	end

end
