require 'spec_helper'
describe Person do

	before(:all) { run_generator }

  after(:all) { run_destroy }
	
	it "should have a sql_searchable class method" do
		Person.should respond_to(:sql_searchable)
	end
	
	it "should have a sql_sortable class method" do
		Person.should respond_to(:sql_sortable)
	end

	describe "scopes" do
		
		
		describe "search" do
			before {(1..50).each { FactoryGirl.create(:person) }}
			describe "returns only the records that match the search text in the fields specified" do
				it "returns records with a first_name that matches 'John'" do
					Person.sql_search("John").count.should == 50
				end
	  		it "returns records with a first_name that matches 'Non-existent person'" do
	  			Person.sql_search("Non-existent person").count.should == 0
	  		end
	  		it "returns records with a first_name that matches 'John_1'" do
	  			Person.sql_search("John_1").count.should == 11
	  		end
	  		it "returns records with a last_name that matches 'Doe_2'" do
	  			Person.sql_search("Doe_20").count.should == 1
	  		end
	  		it "returns records with an email that matches 'johndoe_3'" do
	  			#There is an email matching the string, but Person doesn't specify that column as searchable
	  			Person.sql_search("johndoesemail_36").count.should == 0
	  		end
	  	end  

		end
	  
		describe "sort" do
			
			before do
				@people = []
				(1..50).each do 
					@people << FactoryGirl.create(:person, first_name: "John_#{Random.rand(1..99)}", 
											last_name: "Doe_#{Random.rand(1..99)}")
				end
			end
			it "uses default scope ordering of last_name" do
				Person.all.map { |e| e.send(:last_name) }.uniq == 
      	@people.sort_by{ |p| p.send(:last_name) }.map { |e| e.send(:last_name) }.uniq
			end
			it "sorts by first_name ascending" do
				expect(same_order?(Person, :first_name, @people)).to be true
			end  
			it "sorts by first_name descending" do
				expect(same_order?(Person, :first_name, @people, false)).to be true
			end  
			it "sorts by last_name ascending" do
				expect(same_order?(Person, :last_name, @people)).to be true
			end
			it "sorts by last_name descending" do
				expect(same_order?(Person, :last_name, @people, false)).to be true
			end
			it "does not sort by age because it is not specified as searchable in the model" do
				expect(same_order?(Person, :age, @people)).to be false
			end
			it "quietly uses default sort column (last name) when passing an invalid column name " do
				Person.sql_sort(:invalid_column_name, :asc).map { |e| e.send(:last_name) }.uniq
					.should eq Person.order(:last_name).map { |e| e.send(:last_name) }.uniq
			end
			
			describe "sortable options" do
				describe "sort helpers" do
				  it "returns an array of arrays to populate the sort dropdown" do
				  	Person.sort_cols_for_dropdown
				  	.should eq [["First name", "first_name"],
											 ["First name [desc]", "first_name desc"],
											 ["Last name", "last_name"],
											 ["Last name [desc]", "last_name desc"],
											 ["Email", "email"],
											 ["Email [desc]", "email desc"],
											 ["Date last changed [desc]", "updated_at desc"]]
				  end
				end  
			end
			
		end

		describe "search and sort together" do
			before do
				@people = []
				(1..50).each do 
					@people << FactoryGirl.create(:person, 
											last_name: "Doe_#{Random.rand(1..99)}")
				end
			end
		  it "returns records with a first_name that matches 'John_1' sorted by first_name" do
  			results = Person.sql_sort(:first_name).sql_search("John_1")
  			results.count.should == 11
  			results.map { |e| e.first_name }.uniq 
      		.should eq results.sort_by{ |p| p.first_name }.map { |e| e.first_name }.uniq
  		end
  		
		  it "returns consistent results when sql_sort is called after sql_search" do
		  	Person.sql_sort(:first_name).sql_search("John_1")
		  		.should eq Person.sql_search("John_1").sql_sort(:first_name)
		  end

		  describe "-able attributes" do
		  	it "has a sortable? method" do
		  		Person.should respond_to :sortable?
		  		Person.sortable?.should be true
		  	end
		  	
      end
		
		end

	end
  
end