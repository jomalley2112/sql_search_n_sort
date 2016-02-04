require 'spec_helper'

#The main reason for this spec is to make sure that external parameters defined in the model can be suppressed within the search form
describe "Items" do
	before(:all) do
    run_generator
  end

  after(:all) do 
  	run_destroy
  end

  describe "Allows exiting url parameters to be suppressed when searching/sorting" do
    context "When unwanted parameter names are specified in the suppress_search_params config" do
    	before { SqlSearchNSort.config.suppress_search_params = ["restricted_1", "restricted_2"] }
	    context "when ...searching" do
	    	it "doesn't pass them along to the Item#index action" do
		    	visit items_path(good_param: "good", restricted_1: "bad", restricted_2: "bad")
		    	fill_in("search_for", with: "arbitrary search string")
		    	click_button "Find"
		    	sleep 1
		    	expect(page.current_url).not_to include("bad")
		    end
	    end
	    context "...when sorting" do
	    	it "has no affect on the parameters passed to #index", js: true do
	    		visit items_path(good_param: "good", restricted_1: "bad", restricted_2: "bad")
	    		binding.pry
		    	select("Descr", from: "sort_by")
		    	sleep 2
		    	expect(page.current_url).to include("restricted_1")
	    	end
	    end
	  end

  end
  

end