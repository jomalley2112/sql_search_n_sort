require 'spec_helper'

#The main reason for this spec is to make sure that external parameters defined in the model can be suppressed within the search form
describe "Items" do
	before(:all) do
    run_generator
  end

  after(:all) do 
  	run_destroy
  end

  describe "Upon search from submission any parameters specified in the model specified as such are suppressed and Not passed along" do
    it "doesn't pass along either restricted_1 or restricted_2 to the Item#index action" do
    	binding.pry
    	visit items_path(good_param: "good", restricted_1: "bad", restricted_2: "bad")
    	fill_in("search_for", with: "arbitrary search string")
    	click_button "Find"
    	sleep 1
    	expect(page.current_url).not_to include("bad")
    end
  end

end