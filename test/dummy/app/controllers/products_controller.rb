class ProductsController < ApplicationController

  # GET /products
  def index
    @products = Product.sql_sort(@sort_by, @sort_dir)
  end

  
end