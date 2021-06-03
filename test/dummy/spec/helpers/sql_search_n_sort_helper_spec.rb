require 'spec_helper'

describe SqlSearchNSortHelper, type: :helper do

	before(:all) do
    run_generator
  end

  after(:all) do 
  	run_destroy
  end

	describe "#hide_current_params" do

		before do
			controller.request.query_parameters[:param_1] = "1"
			controller.request.query_parameters[:param_2] = "2"
		end
		
		it "returns the current request parameters as hidden fields" do
			html_fragment = Nokogiri::HTML(helper.hide_current_params)
			
			expect(
				html_fragment.at_css("input[type='hidden'][name='param_1'][value='1']")
			).not_to be_nil

			expect(
				html_fragment.at_css("input[type='hidden'][name='param_2'][value='2']")
			).not_to be_nil
		end

		it "does not return any parameters specified in the 'suppress' argument" do
			controller.request.query_parameters[:unwanted_1] = "unwanted"
			controller.request.query_parameters[:unwanted_2] = "unwanted"
			
			expect(helper.hide_current_params("unwanted_1", "unwanted_2"))
				.not_to include("unwanted")
		end

	end


end