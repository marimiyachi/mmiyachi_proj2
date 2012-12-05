class SavedsController < ApplicationController

  # POST /saved/saved_item_id/addcart
  # Requires: user logged in, owns cart, and saved item in saved list
  # Modifies: Cart_items, Saveds
  # Effects: deletes saved item and add cart_item to user's cart that points to corresponding item
  def add_cart
    @saved = Saved.find(params[:id])
    @storekeeper = Storekeeper.find_by_id(params[:sid])
    @item = Item.find_by_id(@saved.item_id)
    @storekeeper.add_item(@item)
    @saved.destroy
    redirect_to :back
  end

end
