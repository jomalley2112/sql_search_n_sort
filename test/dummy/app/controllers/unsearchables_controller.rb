class UnsearchablesController < ApplicationController
	def index
		@unsearchables = Unsearchable.all
	end
end