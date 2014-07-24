require 'spec_helper'

describe Vehicle do
  describe "sort" do
    describe "sortable options" do
			describe "sort helpers" do
			  it "returns an array of arrays to populate the sort dropdown" do
			  	# binding.pry
			  	Vehicle.sort_cols_for_dropdown
			  		.should eq [["Year", "year"],
								       ["Year [desc]", "year desc"],
								       ["Model", "model"],
								       ["Model [desc]", "model desc"],
								       ["Color", "color"],
								       ["Color [desc]", "color desc"],
								       ["Make", "manufacturer"],
								       ["Make [desc]", "manufacturer desc"]]
			  end
			end  
		end
  end
end
