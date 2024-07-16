class HomeController < ApplicationController
  def index
    @products = Product.all

    if params[:filter] == 'on_sale'
      @products = @products.where('sale_price IS NOT NULL AND sale_price < price AND sale_price != 0.0')
    elsif params[:filter] == 'new'
      @products = @products.where(new_arrival: true)
    end
  end
end
