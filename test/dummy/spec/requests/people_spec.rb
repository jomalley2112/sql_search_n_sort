require 'spec_helper'

describe "People" do
  describe "GET /people" do
  	# before(:each) do
  	#   (1..25).each { FactoryGirl.create(:person) }
  	# end
    describe "search", :js => false do
      
    end

    describe "request sort" do
    	before(:each) do
    		@people = []
				(1..50).each do 
					@people << FactoryGirl.create(:person, first_name: "John_#{Random.rand(1..99)}", 
											last_name: "Doe_#{Random.rand(1..99)}", email: "johndoesemail_#{Random.rand(1..99)}@domain.com")
				end  
    	end
    	
      it "shows sort dropdown with default sort order selected when no sorting is chosen" do
      	pending "pre select default sort col in javascript"
      	visit people_path
      	find("select#sort_by").value.should eq "last_name"
      end

      it "sorts by first name when selected", :js => true do
      	visit people_path
      	select("Email", :from => "sort_by") #just to force onchange event for next line
      	select("First name", :from => "sort_by")
      	sleep 0.5
      	first_names = all(:xpath, "//table/tbody/tr/td[1]")
      	first_names.map(&:text).should == first_names.map(&:text).sort
      end
      it "sorts by last name when selected", :js => true do
      	visit people_path
      	select("Last name", :from => "sort_by")
      	sleep 0.5
      	last_names = all(:xpath, "//table/tbody/tr/td[2]")
      	last_names.map(&:text).should == last_names.map(&:text).sort
      end
      it "sorts by last name descending when selected", :js => true do
      	visit people_path
      	select("Last name [desc]", :from => "sort_by")
      	sleep 0.5
      	last_names = all(:xpath, "//table/tbody/tr/td[2]")
      	last_names.map(&:text).should == last_names.map(&:text).sort.reverse
      end
    end
    
    describe "both search and sort" do
      
    end
  end
end
