class OrdersController < ApplicationController
  def index
    @orders = Order.group_by_status
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to orders_path
  end

  def order_params
    params.require(:order).permit(:status)
  end
end
