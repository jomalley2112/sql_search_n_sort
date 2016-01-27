require 'spec_helper'

describe Comment do

 	describe "Associations" do
 	  it { is_expected.to respond_to(:article) }
 	end
 	describe "Modules" do
 		#just to verify the model is extending the module
	 	it "extends SqlSearchableSortable module" do
	 		Comment.singleton_class.included_modules.include?(SqlSearchableSortable)
	 	end
	end

	describe "Sort" do
	  describe "Allows sorting by joined model column" do
			before do
				(1..5).each do
					article = FactoryGirl.create(:article, headline: "Some Article Headline #{rand(1..9)}")
					(1..3).each do
						FactoryGirl.create(:comment, article: article)
					end  	
				end
				
			end
			
		  it "sorts by article.headline as defined in the model" do
		  	binding.pry
		  	#just a starting point...probably need to get more granual
		  end
		end
	end
	
	describe "Search" do
	  pending
	end
 
end
