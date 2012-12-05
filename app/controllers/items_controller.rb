class ItemsController < ApplicationController

  # index???

  # GET /items/1
  # Requires: user logged in and item with id exists
  # Effects: returns page with full item attribute information
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # Requires: user logged in and owns store
  # Effects: returns form to create new item
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  # Requires: user logged in and owns store with item
  # Effects: returns form to edit given item
  def edit
    @item = Item.find(params[:id])
    @store = Store.find_by_id(@item.store_id)
  end

  #  ????
  # Places item into customer cart
  # Updates the quantity of the Item object
  # Adds Cart Item object to customer cart
  def basket
    @item = Item.find(params[:id])
    @cart = Cart.find(params[:sid])
    @cart.add_item(@item)
    redirect_to @cart
  end

  # POST /items
  # Requires: user logged in and owns store
  # Modifies: Items
  # Effects: creates new item in store and redirects to the item's page
  def create
    @item = current_storekeeper.stores.first.items.build(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # Requires: user logged in and owns store and item with id exists
  # Modifies; Items
  # Effects: updates attributes of specified item
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # Requires: user logged in and owns store adn item with id exists
  # Modifies: Items
  # Effects: item deleted from database and redirected to home page
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
end
