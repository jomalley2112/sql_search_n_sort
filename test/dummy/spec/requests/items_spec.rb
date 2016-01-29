require 'spec_helper'

#The main reason for this spec is to make sure that external parameters defined in the model can be suppressed within the search form
describe "Items" do
	before(:all) do
    run_generator
  end

  after(:all) do 
  	run_destroy
  end

  describe "Allows exiting url parameters to be suppressed when searching" do
    context "When unwanted parameter names are specified in the sql_search_n_sort config" do
    	before { SqlSearchNSort.config.suppress_search_params = ["restricted_1", "restricted_2"] }
	    it "doesn't pass them along to the Item#index action" do
	    	# binding.pry
	    	visit items_path(good_param: "good", restricted_1: "bad", restricted_2: "bad")
	    	fill_in("search_for", with: "arbitrary search string")
	    	click_button "Find"
	    	sleep 1
	    	#TODO: This doesn't really address the spec...may bebetter served in a controller spec
	    	expect(page.current_url).not_to include("bad")
	    end
	  end

  end
  

end