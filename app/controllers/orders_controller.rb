class OrdersController < ApplicationController
  def index
    @count = Order.count
    @orders = Order.group_by_status
  end

  def show
    @order = Order.find(params[:id])
  end
end
