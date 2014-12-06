class ItemsController < ApplicationController
  def index
    if params[:show_inactive] == "true"
      @items = Item.all
    else
      @items = Item.where(active: true)
    end
  end

  def activate
    item = Item.find(params[:id])
    item.update(active: true)
    redirect_to items_path(show_inactive: true)
  end

  def show
    @item = Item.find(params[:id].to_i)
  end
end
