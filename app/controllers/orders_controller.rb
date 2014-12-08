class OrdersController < ApplicationController
  def index
    # puts params
    @orders = Order.group_by_status
  end

  def show
    @order = Order.find(params[:id])
  end
end
