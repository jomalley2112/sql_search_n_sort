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

	describe "#sql_sort" do
	  
		before do
			Article.record_timestamps = false
			Comment.record_timestamps = false
			(1..5).each do
				article = create(:article, headline: "Some Article Headline #{rand(1..9)}", updated_at: Time.now + (rand(1..9)).minutes, created_at: Time.now - (rand(1..9)).minutes)
				(1..3).each do
					create(:comment, article: article, updated_at: Time.now + (rand(1..9)).minutes, created_at: Time.now - (rand(1..9)).minutes)
				end  	
			end
			expect(Comment.count).to be > 0 #non-trivial for sorting
		end
		

		describe "Allows sorting by joined model column" do
		  it "sorts by article.headline as defined in the model" do
		  	comments = Comment.joins(:article).sql_sort("headline")
		  	expect(comments.pluck(:headline)).to eq(comments.pluck(:headline).sort)
		  end
		end
		
		describe "Column Naming Conflicts" do
			context "when joined tables share a column name" do
				let!(:comments_1) { Comment.joins(:article).sql_sort("updated_at") }
				let!(:comments_2) { Comment.joins(:article).sql_sort("created_at") }
				describe "sorts by the column from the table specified within the hash (or the base table)" do
					it "sorts using the comments table for updated_at" do
						expect(comments_1.pluck("comments.updated_at")).to eq(comments_1.pluck("comments.updated_at").sort)
					end
					it "sorts using the articles table for created_at" do
						expect(comments_2.pluck("articles.created_at")).to eq(comments_2.pluck("articles.created_at").sort)
					end
				end
		  end
		end
	end
	

 
end
