class PeopleController < ApplicationController
	def index
		@people = Person.sql_search(params[:search_for]).sql_sort(@sort_by, (@sort_dir))
	end

	def search_only_index
		@people = Person.sql_search(params[:search_for])
	end

	def sort_only_index
		@people = Person.sql_sort(@sort_by, (@sort_dir))
	end
end
