require 'spec_helper'
require 'pry'

describe "People" do
  before(:all) do
    run_generator
    load "#{ Rails.root }/app/helpers/sql_search_n_sort_helper.rb"
    load "#{ Rails.root }/app/controllers/application_controller.rb"
  end

  after(:all) { run_destroy }

  describe "GET /people" do
  	# before(:each) do
  	#   (1..25).each { FactoryGirl.create(:person) }
  	# end
    describe "search only", :js => false do
      it "displays a search box and a find and clear button" do
      	visit search_people_path
      	page.should have_selector("input#search_for")
      	page.should have_selector("button#submit-search")
      	page.should have_selector("button#clear-search")
      end

      it "clears the search", :js => true do
      	visit search_people_path
      	fill_in("search_for", :with => "Search Text")
      	click_button("clear-search")
      	first("input#search_for").value.should eq ""
      end

      describe "perform searches", :js => true do
      	before(:each) do
					FactoryGirl.create(:person, first_name: "Fred", last_name: "Bradley")
					FactoryGirl.create(:person, first_name: "Brad", last_name: "Johnson")
					FactoryGirl.create(:person, first_name: "John", last_name: "Williams")
					FactoryGirl.create(:person, first_name: "Will", last_name: "Farley")
					FactoryGirl.create(:person, first_name: "Joseph", email: "jo@brads.net")
				end
      	
      	it "returns only rows that have first or last name matching case-insensitive 'brad'" do
      		visit search_people_path
	      	first("tbody").all("tr").count.should eq 5
	      	fill_in("search_for", :with => "brad")
      		click_button("submit-search")
      		first("tbody").all("tr").count.should eq 2 #not 3 because Joseph's email isn't searchable
      	end
      	it "returns only rows that have first or last name matching case-insensitive 'wIlL'" do
      		visit search_people_path
	      	first("tbody").all("tr").count.should eq 5
	      	fill_in("search_for", :with => "wIlL")
      		click_button("submit-search")
      		first("tbody").all("tr").count.should eq 2
      	end
      	it "returns only rows that have first or last name matching case-insensitive 'JO'" do
      		visit search_people_path
	      	first("tbody").all("tr").count.should eq 5
	      	fill_in("search_for", :with => "JO")
      		click_button("submit-search")
      		first("tbody").all("tr").count.should eq 3
      	end
      	it "shows all listings again when search is cleared" do
      		visit search_people_path
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
					FactoryGirl.create(:person, first_name: "John_#{Random.rand(1..99)}", 
						last_name: "Doe_#{Random.rand(1..99)}", email: "johndoesemail_#{Random.rand(1..99)}@domain.com")
				end  
    	end
    	
      it "shows sort dropdown with default sort order selected when no sorting is chosen", :js => true do
      	visit sort_people_path
        find("select#sort_by").value.should eq "last_name"
      end

      it "sorts by first name when selected", :js => true do
      	visit sort_people_path
      	select("Email", :from => "sort_by") #just to force onchange event for next line
      	select("First name", :from => "sort_by")
      	sleep 0.5
      	first_names = all(:xpath, "//table/tbody/tr/td[1]")
      	first_names.map(&:text).should == first_names.map(&:text).sort
      end
      it "sorts by last name when selected", :js => true do
      	visit sort_people_path
      	select("Last name", :from => "sort_by")
      	sleep 0.5
      	last_names = all(:xpath, "//table/tbody/tr/td[2]")
      	last_names.map(&:text).should == last_names.map(&:text).sort
      end
      it "sorts by last name descending when selected", :js => true do
        visit sort_people_path
      	select("Last name [desc]", :from => "sort_by")
      	sleep 0.5
      	last_names = all(:xpath, "//table/tbody/tr/td[2]")
      	last_names.map(&:text).should == last_names.map(&:text).sort.reverse
      end
      it "defaults to valid ascending search if invalid sort direction, but valid 
      		sort column value is passed in", :js => false do
      	visit sort_people_path(:sort_by => "email invalid_direction")
      	find("select#sort_by").value.should eq "email"
      end

      it "allows sorting by column that is specifying extended options 
      		hash to sql_searchable in the model", :js => true do
      		p1 = FactoryGirl.create(:person, :email => "p1@domain.com")
      		sleep 1
      		p2 = FactoryGirl.create(:person, :email => "p2@domain.com")
      		visit sort_people_path
      		select("Date last changed [desc]", :from => "sort_by")
      		emails = all(:xpath, "//table/tbody/tr/td[3]")
      		emails[0].text.should eq p2.email
      		emails[1].text.should eq p1.email
      end
    end
  
    
    describe "both search and sort" do
    	before(:each) do
    		(1..50).each do 
					FactoryGirl.create(:person, first_name: "John_#{Random.rand(1..99)}", 
						last_name: "Doe_#{Random.rand(1..99)}", email: "johndoesemail_#{Random.rand(1..99)}@domain.com")
				end  
    	end
      it "keeps same sort order after search", :js => true do
      	visit people_path
      	select("First name", :from => "sort_by")
      	sleep 0.5
      	first_names = all(:xpath, "//table/tbody/tr/td[1]")
      	first_names.map(&:text).should == first_names.map(&:text).sort
      	fill_in("search_for", :with => "john_2")
      	click_button("submit-search")
      	sleep 0.5
      	find("select#sort_by").value.should eq "first_name"
      	john_2_first_names = all(:xpath, "//table/tbody/tr/td[1]").select { |fn| fn.text.downcase == 'john_2' }
      	john_2_first_names.map(&:text).should == john_2_first_names.map(&:text).sort
      end

      it "keeps the same search results after re-sort", :js => true do
      	visit people_path
      	all(:xpath, "//table/tbody/tr").count.should eq 50
      	fill_in("search_for", :with => "john_2")
      	click_button("submit-search")
      	john_2_count = all(:xpath, "//table/tbody/tr").count
      	#make sure search did indeed happen first
      	john_2_count.should eq all(:xpath, "//table/tbody/tr/td[1]").count { |e| e.text =~ /john_2/i }
      	select("Email [desc]", :from => "sort_by") #resubmits
				sleep 0.5
      	all(:xpath, "//table/tbody/tr").count.should eq john_2_count
			end
    end

    describe "existing params" do
      it "passes along existing params when search form is submitted" do
      	visit people_path(filter: "managers", aged: "42")
      	fill_in("search_for", :with => "irrelevant search text")
      	click_button("submit-search")
      	current_url.should match("filter=managers")
      	current_url.should match("aged=42")
      end
      it "passes along existing params when re-sorting" do
      	visit people_path(filter: "sales", aged: "43")
      	select("Email", :from => "sort_by")
      	current_url.should match("filter=sales")
      	current_url.should match("aged=43")
      end
    end
  end
end
