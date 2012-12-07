class StorekeepersController < ApplicationController
  before_filter :signed_in_user, only: [:show, :cart]
  before_filter :correct_user, only: [:show, :cart]

  protect_from_forgery :secret => "1234567890"

  # GET /storekeepers/1
  # Requires: user signed in and matches user_id
  # Effects: returns storekeeper information
  def show
    @storekeeper = Storekeeper.find(params[:id])
    @store = @storekeeper.stores.first
    @orders = Order.all
    @item = Item.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @storekeeper }
    end
  end

  # POST /storekeepers/id/fufill
  # Requires: user signed in and order place in user's store
  # Modifies: Order_its, Orders
  # Effects: change status of relevant order items to "Fufilled"
  def fufill
    @order = Order.find(params[:oid])
    @storekeeper = Storekeeper.find(params[:id])
    @order.fufill(@storekeeper)
    redirect_to :back
  end

  # GET /storekeepers/new
  # Requires: user logged out
  # Effects: returns form to create new user account
  def new
    @storekeeper = Storekeeper.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @storekeeper }
    end
  end

  # POST /storekeepers
  # Requires: valid user information
  # Modifies: Storekeepers, Carts
  # Effects: creates user with given attributes and cart belonging to the user and redirects to user profile
  def create
    @storekeeper = Storekeeper.new(params[:storekeeper])
    if @storekeeper.save
      sign_in @storekeeper
      redirect_to @storekeeper
    else
      render 'new'
    end
  end

  # GET /storekeepers/id/cart
  # Requires: user logged in
  # Effects: returns cart information for given user
  def cart
    @storekeeper = Storekeeper.find(params[:id])
    @cart_items = @storekeeper.cart_items
    @t = @storekeeper.total

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end

  # Processes the cart for final checkout
  # POST /storekeeper/id/checkout
  # Requires: user logged in, owns cart, and at least one item in cart with quantity > 0
  # Modifies: cart_items, orders, and order_items
  # Effects: creates order from cart that can be viewed by user
  def checkout
    @storekeeper = Storekeeper.find(params[:id])
    @order = @storekeeper.final_checkout(current_storekeeper)
  end

  def addsave
    @cart_item = CartItem.find(params[:id])
    @storekeeper = Storekeeper.find_by_id(@cart_item.storekeeper_id)
    @cart_item.save_list
    render partial: 'storekeepers/cart_items', :locals => {:item => @cart_item}
  end

  def addcart
    @cart_item = CartItem.find(params[:id])
    @storekeeper = Storekeeper.find_by_id(@cart_item.storekeeper_id)
    @cart_item.unsave_list
    render partial: 'storekeepers/cart_items', :locals => {:item => @cart_item}
  end

end
