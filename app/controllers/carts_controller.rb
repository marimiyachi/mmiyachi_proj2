class CartsController < ApplicationController
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user, only: [:show]

  # GET /carts/1
  # Requires: user logged in
  # Effects: returns cart information for given user
  def show
    @cart = Cart.find(params[:id])
    @t = @cart.total(@cart.cart_items)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end

  # Processes the cart for final checkout
  # POST /carts/id/checkout
  # Requires: user logged in, owns cart, and at least one item in cart with quantity > 0
  # Modifies: cart_items, orders, and order_items
  # Effects: creates order from cart that can be viewed by user
  def checkout
    @cart = Cart.find(params[:id])
    @customer = current_storekeeper
    @order = @cart.final_checkout(@customer)
  end

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
