module Exceptions
	class UnsearchableType < StandardError
	  def initialize(object, col_name)
	  	super "Column '#{col_name}' of model #{object.model_name.human} is not searchable because
							it is not of type string or text."
	  end
	end
end