require 'spec_helper'

#The reason for this spec is to make sure behavior is as expected when we specify 
# :asc as the default sort direction
describe "Articles" do

	before(:all) do
    run_generator
    load "#{ Rails.root }/app/helpers/sql_search_n_sort_helper.rb"
    load "#{ Rails.root }/app/controllers/application_controller.rb"
  end

  after(:all) do 
  	run_destroy
  end

  describe "GET /articles" do
  	before(:each) do
			(1..50).each do
		  	FactoryGirl.create(:article)
			end
		end
    it "sorts by default column in ascending order when
    		 ascending is specified in the model" do
    	visit articles_path
    	find("select#sort_by").value.should eq "date_pub"
    	pub_dates = all(:xpath, "//table/tbody/tr/td[3]")
      pub_dates.map(&:text).should == pub_dates.map(&:text).sort
    end
  end
end
