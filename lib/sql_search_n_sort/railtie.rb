require 'sql_search_n_sort/app/helpers/sql_search_n_sort_helper'
module SqlSearchNSort
  class Railtie < Rails::Railtie
    initializer "sql_search_n_sort.helper" do
      ActionView::Base.send :include, SqlSearchNSortHelper
    end
  end
end