class StorekeepersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :show, :order]
  before_filter :correct_user, only: [:edit, :update, :show, :order]

  protect_from_forgery :secret => "1234567890"

  # GET /storekeepers/1
  # Requires: user signed in and matches user_id
  # Effects: returns storekeeper information
  def show
    @storekeeper = Storekeeper.find(params[:id])
    @store = @storekeeper.stores.first
    @items = @store.items
    @orders = Order.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @storekeeper }
    end
  end

  # POST /storekeepers/id/fufill_order
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

  # GET /storekeepers/1/edit
  # Requires: user logged in and matches user_id
  # Effects: returns form to edit user attributes
  def edit
    @storekeeper = Storekeeper.find(params[:id])
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

  # PUT /storekeepers/1
  # Requires: user logged in and matches user_id
  # Modifies: Storekeepers
  # Effects: updates user attributes as specified
  def update
    @storekeeper = Storekeeper.find(params[:id])

    respond_to do |format|
      if @storekeeper.update_attributes(params[:storekeeper])
        format.html { redirect_to @storekeeper, notice: 'Storekeeper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @storekeeper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /storekeepers/1
  # DELETE /storekeepers/1.json
  # ???
 # def destroy
 #   @storekeeper = Storekeeper.find(params[:id])
 #   @storekeeper.destroy

 #   respond_to do |format|
 #     format.html { redirect_to storekeepers_url }
 #     format.json { head :no_content }
 #   end
 # end

  # Authenticate users
  private
    # redirect if user is not logged in
    def signed_in_user
      redirect_to storekeepersignup_path, notice: "Please sign in." unless signed_in?
    end

    # redirect if user is accessing material they don't own
    def correct_user
      redirect_to root_path, notice: "Restricted access." unless current_storekeeper?(Storekeeper.find(params[:id]))
    end
end
