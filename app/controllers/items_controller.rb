class ItemsController < ApplicationController
  def index
    if params[:show_inactive]
      @items = Item.all
    else
      @items = Item.active
    end
  end

  def show
    @item = Item.find(params[:id].to_i)
  end
end
