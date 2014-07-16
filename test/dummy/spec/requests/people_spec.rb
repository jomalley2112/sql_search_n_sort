require 'spec_helper'

describe "People" do
  describe "GET /people" do
  	# before(:each) do
  	#   (1..25).each { FactoryGirl.create(:person) }
  	# end
    
    describe "search", :js => false do
      it "displays a search box" do
      	visit people_path
      	page.should have_selector("input#search_for")
      end
    end

    describe "sort" do
    	before(:each) do
    		@people = []
				(1..50).each do 
					@people << FactoryGirl.create(:person, first_name: "John_#{Random.rand(1..99)}", 
											last_name: "Doe_#{Random.rand(1..99)}", email: "johndoesemail_#{Random.rand(1..99)}@domain.com")
				end  
    	end
    	
      it "shows sort dropdown with default sort order selected when no sorting is chosen" do
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
      it "defaults to valid ascending search if invalid sort direction, but valid 
      		sort column value is passed in", :js => false do
      	visit people_path(:sort_by => "email invalid_direction")
      	find("select#sort_by").value.should eq "email"
      end

      it "allows sorting by column that is specifying extended options 
      		hash to sql_searchable in the model", :js => true do
      		p1 = FactoryGirl.create(:person, :email => "p1@domain.com")
      		sleep 1
      		p2 = FactoryGirl.create(:person, :email => "p2@domain.com")
      		visit people_path
      		select("Date last changed [desc]", :from => "sort_by")
      		emails = all(:xpath, "//table/tbody/tr/td[3]")
      		#binding.pry
      		emails[0].text.should eq p2.email
      		emails[1].text.should eq p1.email
      end
    end
    
    describe "both search and sort" do
      
    end
  end
end
