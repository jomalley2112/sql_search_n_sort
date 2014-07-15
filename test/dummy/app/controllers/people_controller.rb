class PeopleController < ApplicationController
	def index
		@people = Person.sql_sort(@sort_by, (@sort_dir || :asc))
	end
end
