class ItemsActivationController < ApplicationController
  def update
    # puts params
    item = Item.find(params[:id].to_i)
    item.update(active: true)
    redirect_to items_path
  end
end
