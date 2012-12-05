class ItemsController < ApplicationController

  # GET /items/1/edit
  # Requires: user logged in and owns store with item
  # Effects: returns form to edit given item
  def edit
    @item = Item.find(params[:id])
    @store = Store.find_by_id(@item.store_id)
  end

  # POST /storekeepers/id/basket
  # Requires: user logged in
  # Modifies: Cart_items
  # Effects: places item into customer cart
  def basket
    @item = Item.find(params[:id])
    @storekeeper = Storekeeper.find_by_id(params[:sid])
    @storekeeper.add_item(@item)
    redirect_to shopping_cart_url(@storekeeper)
  end

  # POST /items
  # Requires: user logged in and owns store
  # Modifies: Items
  # Effects: creates new item in store and redirects to the item's page
  def create
    @item = current_storekeeper.stores.first.items.build(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to :back, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
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
        format.html { redirect_to current_storekeeper, notice: 'Item was successfully updated.' }
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
      format.html { redirect_to current_storekeeper }
      format.json { head :no_content }
    end
  end
end
