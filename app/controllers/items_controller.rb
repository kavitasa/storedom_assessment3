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

  def update
    item = Item.find(params[:id])
    item.update_attributes(item_params)
    # item.update(active: true)
    redirect_to root_path
  end

  def item_params
    # binding .pry
    params.require(:item).permit(:active)
  end
end
