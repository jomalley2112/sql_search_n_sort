require 'spec_helper'

describe Product do
  before(:each) do
		(1..50).each do
	  	FactoryGirl.create(:product)
		end
	end

  it "allows default sort order to be descending" do
  	Product.order("manufacturer DESC").all.should =~ Product.sql_sort()
	end
end
