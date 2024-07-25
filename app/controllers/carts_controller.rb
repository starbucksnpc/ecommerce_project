class CartsController < ApplicationController
  def show
    @cart = session[:cart] || {}
  end

  def add
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i

    session[:cart] ||= {}
    session[:cart][product_id] = (session[:cart][product_id] || 0) + quantity

    redirect_to cart_path, notice: 'Product added to cart!'
  end

  def remove
    product_id = params[:product_id].to_s

    session[:cart] ||= {}
    session[:cart].delete(product_id)

    redirect_to cart_path, notice: 'Product removed from cart!'
  end

  def update_quantity
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i

    if quantity > 0
      session[:cart][product_id] = quantity
    else
      session[:cart].delete(product_id)
    end

    redirect_to cart_path, notice: 'Quantity updated!'
  end

  def checkout
    redirect_to new_checkout_path
  end
end
