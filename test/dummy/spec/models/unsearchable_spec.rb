require 'spec_helper'

RSpec.describe Unsearchable, :type => :model do
  describe "sql_searchable method doesn't allow unsearchable columns" do
    	it "raises an exception on integer type column" do
    		expect { Unsearchable.sql_searchable(:int) }.to raise_error(Exceptions::UnsearchableType)
    	end

    	it "raises an exception on date type column" do
    		expect { Unsearchable.sql_searchable(:dt) }.to raise_error(Exceptions::UnsearchableType)
    	end

    	it "raises an exception on time type column" do
    		expect { Unsearchable.sql_searchable(:tm) }.to raise_error(Exceptions::UnsearchableType)
    	end

    	it "raises an exception on datetime type column" do
    		expect { Unsearchable.sql_searchable(:dtm) }.to raise_error(Exceptions::UnsearchableType)
    	end

    	it "raises an exception on boolean type column" do
    		expect { Unsearchable.sql_searchable(:bool) }.to raise_error(Exceptions::UnsearchableType)
    	end

    	it "raises an exception on float type column" do
    		expect { Unsearchable.sql_searchable(:flt) }.to raise_error(Exceptions::UnsearchableType)
    	end

    	it "raises an exception on decimal type column" do
    		expect { Unsearchable.sql_searchable(:dec) }.to raise_error(Exceptions::UnsearchableType)
    	end

    	it "raises an exception on binary type column" do
    		expect { Unsearchable.sql_searchable(:bn) }.to raise_error(Exceptions::UnsearchableType)
    	end
  end
end
