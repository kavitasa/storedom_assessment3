class ItemsController < ApplicationController
  def index
    if show_inactive?
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
    redirect_to root_path
  end

  private

  def show_inactive?
    params[:show_inactive] == 'true'
  end

  def item_params
    params.require(:item).permit(:active)
  end
end
