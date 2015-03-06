class Admin::MembersController < ApplicationController
	def index_explicit_setup
		setup_sql_sort(Admin::Member)
		@members = Admin::Member.sql_search(params[:search_for]).sql_sort(@sort_by, (@sort_dir))
		render :index
	end
end