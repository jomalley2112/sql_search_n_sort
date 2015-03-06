require 'spec_helper'

describe "Members" do
  before(:all) do
    run_generator
  end

  after(:all) do 
    run_destroy
  end

  describe "GET /members" do
  	
    describe "sort only" do
    	before(:each) do
    		(1..50).each do 
					FactoryGirl.create(:member, first_name: "John_#{Random.rand(1..99)}", 
						last_name: "Doe_#{Random.rand(1..99)}", email: "johndoesemail_#{Random.rand(1..99)}@domain.com")
				end  
    	end
    
      it "sorts by first name when selected", :js => true do
      	visit admin_members_path
        first("tbody").all("tr").count.should eq 50
      	select("Email", :from => "sort_by") #just to force onchange event for next line
      	select("First name", :from => "sort_by")
      	sleep 0.5
      	first_names = all(:xpath, "//table/tbody/tr/td[1]")
      	first_names.map(&:text).should == first_names.map(&:text).sort
      end
      it "sorts by last name when selected", :js => true do
        visit admin_members_path
      	first("tbody").all("tr").count.should eq 50
        select("Last name", :from => "sort_by")
      	sleep 0.5
      	last_names = all(:xpath, "//table/tbody/tr/td[2]")
      	last_names.map(&:text).should == last_names.map(&:text).sort
      end
      
    end

    describe "perform searches", :js => true do
      before(:each) do
        FactoryGirl.create(:member, first_name: "Fred", last_name: "Bradley")
        FactoryGirl.create(:member, first_name: "Brad", last_name: "Johnson")
        FactoryGirl.create(:member, first_name: "John", last_name: "Williams")
        FactoryGirl.create(:member, first_name: "Will", last_name: "Farley")
        FactoryGirl.create(:member, first_name: "Joseph", email: "jo@brads.net")
      end
      
      it "returns only rows that have first or last name matching case-insensitive 'brad'" do
        visit admin_members_path
        first("tbody").all("tr").count.should eq 5
        fill_in("search_for", :with => "brad")
        click_button("submit-search")
        first("tbody").all("tr").count.should eq 2 #not 3 because Joseph's email isn't searchable
      end
    end
  end
end
