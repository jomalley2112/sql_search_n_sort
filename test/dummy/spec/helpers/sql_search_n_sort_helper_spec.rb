require 'spec_helper'

describe SqlSearchNSortHelper, type: :helper do
	before(:all) do
    run_generator
  end

  after(:all) do 
  	run_destroy
  end
	describe "#hide_current_params" do
		it "returns the current request parameters as hidden fields" do
			controller.request.query_parameters[:param_1] = "1"
			controller.request.query_parameters[:param_2] = "2"
			expect(helper.hide_current_params)
				.to eq("<input id=\"param_1\" name=\"param_1\" type=\"hidden\" value=\"1\" />\n<input id=\"param_2\" name=\"param_2\" type=\"hidden\" value=\"2\" />")
		end
		
	end


end