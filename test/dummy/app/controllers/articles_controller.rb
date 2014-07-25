class ArticlesController < ApplicationController
  def index
  	@articles = Article.sql_sort(@sort_by, @sort_dir)
  end
end
