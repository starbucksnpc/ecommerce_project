class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def new
    @cart = session[:cart] || {}
    @order = Order.new(address: current_user.address, province: current_user.province)
    @order.calculate_total_price(@cart)
    @order.calculate_taxes(@cart)
  end

  def create
    @cart = session[:cart] || {}
    @order = current_user.orders.build(order_params)
    @order.province = current_user.province

    @order.calculate_total_price(@cart)
    @order.calculate_taxes(@cart)

    if @order.save
      @cart.each do |product_id, quantity|
        product = Product.find(product_id)
        @order.order_items.create(product: product, quantity: quantity, unit_price: product.price)
      end
      session[:cart] = {}
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:address, :province_id, :status)
  end
end
