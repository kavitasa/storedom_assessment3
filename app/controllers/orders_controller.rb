class OrdersController < ApplicationController
  def index
    @orders = Order.group_by_status
  end

  def show
    @order = Order.find(params[:id])
  end
end
