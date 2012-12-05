class CartItemsController < ApplicationController

    # DELETE /cart_item/cart_item_id/destroy
    # Requires: user logged in, owns cart and cart_item in cart
    # Modifies: Cart_items, Items
    # Effects: deletes the specified cart item and increments the quantity of the item it pointed to
    def destroy_item
      @cart_item = CartItem.find_by_id(params[:id])
      @item = Item.find_by_id(@cart_item.item_number)
      @item.increment_quantity
      @cart_item.destroy
      redirect_to :back
    end

    # POST /cart_item/cart_item_id/save
    # Requires: user logged in, owns cart and cart_item in cart
    # Modifies: Cart_items, Saved_items
    # Effects: deletes the specified cart item and creates a saved item that points to the same item
    def save_item
      @cart_item = CartItem.find_by_id(params[:id])
      @item = Item.find_by_id(@cart_item.item_number)
      @saved_item = current_storekeeper.saveds.create(item_id: @item.id)
      @cart_item.destroy
      redirect_to :back
    end
end