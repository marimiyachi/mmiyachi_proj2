class CartsController < ApplicationController
  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    @cart = Cart.find(params[:id])
    @t = @cart.total(@cart.cart_items)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/new
  # GET /carts/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # Processes the cart for final checkout
  def checkout
    @cart = Cart.find(params[:id])
    @customer = current_storekeeper
    @cart.final_checkout(@customer)
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = current_storekeeper.carts.build(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render json: @cart, status: :created, location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url }
      format.json { head :no_content }
    end
  end

  # DELETE Cart Item object
  # Increment the Item object quantity
  def destroy_item
    @cart_item = CartItem.find_by_id(params[:id])
    @item = Item.find_by_id(@cart_item.item_number)
    @item.increment_quantity
    @cart_item.destroy
  end

  # DELETE Cart Item object
  # Create new Saved object
  def save_item
    @cart_item = CartItem.find_by_id(params[:id])
    @item = Item.find_by_id(@cart_item.item_number)
    @saved_item = current_storekeeper.saveds.create(item_id: @item.id)
    @cart_item.destroy
  end
end
