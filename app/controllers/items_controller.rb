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

  private

  def show_inactive?
    params[:show_inactive] == 'true'
  end
end
