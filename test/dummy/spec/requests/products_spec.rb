require 'spec_helper'

describe "Products" do
	before(:all) do
    run_generator
    load "#{ Rails.root }/app/helpers/sql_search_n_sort_helper.rb"
    load "#{ Rails.root }/app/controllers/application_controller.rb"
  end

  after(:all) do 
  	run_destroy
  end

  describe "GET /products" do
    before(:each) do
			(1..50).each do
		  	FactoryGirl.create(:product)
			end
		end
		it "sorts by product manufacturer in descending order by default", :js => false do
			visit products_path
			find("select#sort_by").value.should eq "manufacturer desc"
		end
  end
end
