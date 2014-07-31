require 'spec_helper'

#The reason for this spec is to make sure sorting acts as expected when there is no
# default sort order specified
describe "Vehicles spec" do
  before(:all) do
    run_generator
  end

  after(:all) { run_destroy }

  describe "GET /vehicles" do
  	# before(:each) do
  	#   (1..25).each { FactoryGirl.create(:vehicle) }
  	# end
    describe "search only", :js => false do
      it "displays a search box and a find and clear button" do
      	visit search_vehicles_path
      	page.should have_selector("input#search_for")
      	page.should have_selector("button#submit-search")
      	page.should have_selector("button#clear-search")
      end

      it "clears the search", :js => true do
      	visit search_vehicles_path
      	fill_in("search_for", :with => "Search Text")
      	click_button("clear-search")
      	first("input#search_for").value.should eq ""
      end

      describe "perform searches", :js => true do
      	before(:each) do
					FactoryGirl.create(:vehicle, manufacturer: "Fred", model: "Bradley")
					FactoryGirl.create(:vehicle, manufacturer: "Brad", model: "Johnson")
					FactoryGirl.create(:vehicle, manufacturer: "John", model: "Williams")
					FactoryGirl.create(:vehicle, manufacturer: "Will", model: "Farley")
					FactoryGirl.create(:vehicle, manufacturer: "Joseph", color: "jobrads.net")
				end
      	
      	it "returns only rows that have manufacturer or model matching case-insensitive 'brad'" do
      		visit search_vehicles_path
	      	first("tbody").all("tr").count.should eq 5
	      	fill_in("search_for", :with => "brad")
      		click_button("submit-search")
      		first("tbody").all("tr").count.should eq 2 #not 3 because Joseph's color isn't searchable
      	end
      	it "returns only rows that have manufacturer or mode matching case-insensitive 'wIlL'" do
      		visit search_vehicles_path
	      	first("tbody").all("tr").count.should eq 5
	      	fill_in("search_for", :with => "wIlL")
      		click_button("submit-search")
      		first("tbody").all("tr").count.should eq 2
      	end
      	it "returns only rows that have manufacturer or model matching case-insensitive 'JO'" do
      		visit search_vehicles_path
	      	first("tbody").all("tr").count.should eq 5
	      	fill_in("search_for", :with => "JO")
      		click_button("submit-search")
      		first("tbody").all("tr").count.should eq 3
      	end
      	it "shows all listings again when search is cleared" do
      		visit search_vehicles_path
	      	first("tbody").all("tr").count.should eq 5
	      	fill_in("search_for", :with => "Fred")
      		click_button("submit-search")
      		first("tbody").all("tr").count.should eq 1
      		click_button("clear-search")
    			first("input#search_for").value.should eq ""
    			first("tbody").all("tr").count.should eq 5
      	end
	      
      end

    end
  
    describe "sort only" do
    	before(:each) do
    		(1..50).each do 
					FactoryGirl.create(:vehicle, manufacturer: "John_#{Random.rand(1..99)}", 
						model: "Doe_#{Random.rand(1..99)}", color: "johndoescolor_#{Random.rand(1..99)}")
				end  
    	end
    	
      it "shows sort dropdown with default sort order selected when no sorting is chosen", :js => true do
      	visit sort_vehicles_path
        find("select#sort_by").value.should eq "year" #first in list because no default
      end

      it "sorts by manufacturer when selected", :js => true do
      	visit sort_vehicles_path
      	select("Color", :from => "sort_by") #just to force onchange event for next line
      	select("Make", :from => "sort_by")
      	sleep 0.5
      	manufacturers = all(:xpath, "//table/tbody/tr/td[1]")
      	manufacturers.map(&:text).should == manufacturers.map(&:text).sort
      end
      it "sorts by model when selected", :js => true do
      	visit sort_vehicles_path
      	select("Model", :from => "sort_by")
      	sleep 0.5
      	models = all(:xpath, "//table/tbody/tr/td[3]")
      	models.map(&:text).should == models.map(&:text).sort
      end
      it "sorts by model descending when selected", :js => true do
        visit sort_vehicles_path
      	select("Model [desc]", :from => "sort_by")
      	sleep 0.5
      	models = all(:xpath, "//table/tbody/tr/td[3]")
      	models.map(&:text).should == models.map(&:text).sort.reverse
      end
      it "defaults to valid ascending search if invalid sort direction, but valid 
      		sort column value is passed in", :js => false do
      	visit sort_vehicles_path(:sort_by => "color invalid_direction")
      	find("select#sort_by").value.should eq "color"
      end

    end
  
    
    describe "both search and sort" do
    	before(:each) do
    		(1..50).each do 
					FactoryGirl.create(:vehicle, manufacturer: "John_#{Random.rand(1..99)}", 
						model: "Doe_#{Random.rand(1..99)}", color: "johndoescolor_#{Random.rand(1..99)}@domain.com")
				end  
    	end
      it "keeps same sort order after search", :js => true do
      	visit vehicles_path
      	select("Make", :from => "sort_by")
      	sleep 0.5
      	manufacturers = all(:xpath, "//table/tbody/tr/td[1]")
      	manufacturers.map(&:text).should == manufacturers.map(&:text).sort
      	fill_in("search_for", :with => "john_2")
      	click_button("submit-search")
      	sleep 0.5
      	find("select#sort_by").value.should eq "manufacturer"
      	john_2_manufacturers = all(:xpath, "//table/tbody/tr/td[1]").select { |fn| fn.text.downcase == 'john_2' }
      	john_2_manufacturers.map(&:text).should == john_2_manufacturers.map(&:text).sort
      end

      it "keeps the same search results after re-sort", :js => true do
      	visit vehicles_path
      	all(:xpath, "//table/tbody/tr").count.should eq 50
      	fill_in("search_for", :with => "john_2")
      	click_button("submit-search")
      	john_2_count = all(:xpath, "//table/tbody/tr").count
      	#make sure search did indeed happen first
      	john_2_count.should eq all(:xpath, "//table/tbody/tr/td[2]").count { |e| e.text =~ /john_2/i }
      	select("Color [desc]", :from => "sort_by") #resubmits
				sleep 0.5
      	all(:xpath, "//table/tbody/tr").count.should eq john_2_count
			end
    end

    describe "existing params" do
      it "passes along existing params when search form is submitted" do
      	visit vehicles_path(filter: "managers", aged: "42")
      	fill_in("search_for", :with => "irrelevant search text")
      	click_button("submit-search")
      	current_url.should match("filter=managers")
      	current_url.should match("aged=42")
      end
      it "passes along existing params when re-sorting", :js => true do
      	visit vehicles_path(filter: "sales", aged: "43")
      	select("Color", :from => "sort_by")
      	current_url.should match("filter=sales")
      	current_url.should match("aged=43")
      end
    end
  end
end
