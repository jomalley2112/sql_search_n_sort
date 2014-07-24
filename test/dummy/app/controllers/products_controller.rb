class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
    #binding.pry
    @products = Product.sql_sort(@sort_by, @sort_dir)
  end

  
end