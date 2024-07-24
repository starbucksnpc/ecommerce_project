class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def new
    @cart = session[:cart] || {}
    @order = Order.new
  end

  def create
    @cart = session[:cart] || {}
    @order = current_user.orders.build(order_params)
    @order.province = current_user.province

    # Calculate taxes
    gst_rate = current_user.province.gst_rate || 0
    pst_rate = current_user.province.pst_rate || 0
    hst_rate = current_user.province.hst_rate || 0
    qst_rate = current_user.province.qst_rate || 0

    @order.gst = @cart.sum { |product_id, quantity| Product.find(product_id).price * quantity * gst_rate }
    @order.pst = @cart.sum { |product_id, quantity| Product.find(product_id).price * quantity * pst_rate }
    @order.hst = @cart.sum { |product_id, quantity| Product.find(product_id).price * quantity * hst_rate }
    @order.qst = @cart.sum { |product_id, quantity| Product.find(product_id).price * quantity * qst_rate }
    @order.total_price = @cart.sum { |product_id, quantity| Product.find(product_id).price * quantity } + @order.gst + @order.pst + @order.hst + @order.qst

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
    params.require(:order).permit(:address, :province_id)
  end
end
