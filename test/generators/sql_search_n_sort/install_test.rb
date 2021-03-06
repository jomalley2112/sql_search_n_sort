require 'test_helper'
require 'generators/sql_search_n_sort/install_generator'

class InstallGeneratorTest < Rails::Generators::TestCase
  
  tests SqlSearchNSort::InstallGenerator
	destination File.expand_path("../tmp", File.dirname(__FILE__))

  def setup
    @args = ["--quiet", "--force"]
    prepare_destination
    copy_dummy_files
  end

  def teardown
    run_generator @args, {:behavior => :revoke}
  end

  test "Assert all files are properly created" do
    assert_no_file "app/views/application/_sort_form.html.haml"
    assert_no_file "app/views/application/_search_form.html.haml"
    assert_no_file "app/assets/javascripts/sql_search_n_sort.js"
    assert_no_file "config/initializers/sql_search_n_sort.rb"
    run_generator @args
    assert_file "app/views/application/_sort_form.html.haml"
    assert_file "app/views/application/_search_form.html.haml"
    assert_file "app/assets/javascripts/sql_search_n_sort.js"
    assert_file "config/initializers/sql_search_n_sort.rb"
  end

  test "Assert lines have been inserted into proper files" do
    
    assert_file "app/controllers/application_controller.rb" do |app_ctrlr|
      assert_no_match(/include SqlSortSetup/, app_ctrlr)
      assert_no_match(/before_action :setup_sql_sort, :only => \[:index/, app_ctrlr)
    end

    assert_file "app/assets/javascripts/application.js" do |app_js|
      assert_no_match(/\/\/= require jquery/, app_js)
    end
    
    run_generator @args
    
    assert_file "app/controllers/application_controller.rb" do |app_ctrlr|
      assert_match(/include SqlSortSetup/, app_ctrlr)
      assert_match(/before_action :setup_sql_sort, :only => \[:index/, app_ctrlr)
    end

    #This test will fail if there is an application.js.coffee instead of an application.js
    assert_file "app/assets/javascripts/application.js" do |app_js|
      assert_match(/\/\/= require jquery/, app_js)
    end
  end

  private
    def copy_dummy_files
      dummy_file_dir = File.expand_path("../dummy_test_files", __FILE__)
      FileUtils.cp_r("#{dummy_file_dir}/app", "#{destination_root}/app")
    end

end
#end