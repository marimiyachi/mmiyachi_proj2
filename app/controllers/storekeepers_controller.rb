class StorekeepersController < ApplicationController
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user, only: [:show]

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
    @cart = Cart.new

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
    @cart = @storekeeper.carts.build(params[:cart])
    if @storekeeper.save
      sign_in @storekeeper
      redirect_to @storekeeper
    else
      render 'new'
    end
  end

end
