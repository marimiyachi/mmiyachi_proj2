class StoresController < ApplicationController
  # GET /stores
  # Requires: user logged in
  # Effects: returns list of all stores
  def index
    @stores = Store.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
    end
  end

  # GET /stores/id
  # Requires: user logged in and store exists with store_id
  # Effects: provide information about specified store
  def shop
    @store = Store.find(params[:id])
    @items = @store.items
    @storekeeper = current_storekeeper
  end

  # GET /stores/new
  # Requires: user logged in and doesn't already have store
  # Effects: returns form to create new store
  def new
    @store = Store.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @store }
    end
  end

  # GET /stores/1/edit
  # Requires: user logged in and owns specified store
  # Effects: returns form to edit specified store
  def edit
    @store = Store.find(params[:id])
  end

  # POST /stores
  # Requires: user logged in and valid store information
  # Modifies: Stores
  # Effects: creates new store owned by user and redirects to store landing page
  def create
    @store = current_storekeeper.stores.build(params[:store])

    respond_to do |format|
      if @store.save
        format.html { redirect_to current_storekeeper, notice: 'Store was successfully created.' }
        format.json { render json: @store, status: :created, location: @store }
      else
        format.html { render action: "new" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stores/1
  # Requires: user logged in and owns store
  # Modifies: Stores
  # Effects: updates store attributes as specified
  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to current_storekeeper, notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end


end
