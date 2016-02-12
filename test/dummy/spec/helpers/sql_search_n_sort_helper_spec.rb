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
			expect(helper.hide_current_params)
				.to eq("<input id=\"param_1\" name=\"param_1\" type=\"hidden\" value=\"1\" />\n<input id=\"param_2\" name=\"param_2\" type=\"hidden\" value=\"2\" />")
		end

		it "does not return any parameters specified in the 'suppress' argument" do
			controller.request.query_parameters[:unwanted_1] = "unwanted"
			controller.request.query_parameters[:unwanted_2] = "unwanted"
			expect(helper.hide_current_params("unwanted_1", "unwanted_2"))
				.to eq("<input id=\"param_1\" name=\"param_1\" type=\"hidden\" value=\"1\" />\n<input id=\"param_2\" name=\"param_2\" type=\"hidden\" value=\"2\" />")
		end

	end


end