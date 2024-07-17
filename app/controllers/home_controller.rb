# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    @products = Product.all

    if params[:filter] == 'on_sale'
      @products = @products.where('sale_price < price AND sale_price != 0')
    elsif params[:filter] == 'new'
      @products = @products.where(new_arrival: true)
    end

    if params[:keyword].present?
      @products = @products.where("products.name LIKE ? OR products.description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    if params[:category_id].present? && params[:category_id] != ""
      @products = @products.joins(:categories).where(categories: { id: params[:category_id] })
    end

    @products = @products.page(params[:page]).per(12) 
  end
end
