class StoresController < ApplicationController

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
    end
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @store = Store.find(params[:id])
    @items = @store.items

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @store }
    end
  end

  # provide information for shopping interface
  # all stores and items available for view to signed in shopkeepers
  def shop
    @store = Store.find(params[:id])
    @items = @store.items
    @storekeeper = current_storekeeper
  end

  # GET /stores/new
  # GET /stores/new.json
  def new
    @store = Store.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @store }
    end
  end

  # GET /stores/1/edit
  def edit
    @store = Store.find(params[:id])
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = current_storekeeper.stores.build(params[:store])

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render json: @store, status: :created, location: @store }
      else
        format.html { render action: "new" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stores/1
  # PUT /stores/1.json
  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { head :no_content }
    end
  end

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
