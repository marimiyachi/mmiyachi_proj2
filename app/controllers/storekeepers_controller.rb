class StorekeepersController < ApplicationController
  # GET /storekeepers
  # GET /storekeepers.json
  def index
    @storekeepers = Storekeeper.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @storekeepers }
    end
  end

  # GET /storekeepers/1
  # GET /storekeepers/1.json
  def show
    @storekeeper = Storekeeper.find(params[:id])
    @stores = @storekeeper.stores

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @storekeeper }
    end
  end

  def order
    @storekeeper = Storekeeper.find(params[:id])
  end

  # GET /storekeepers/new
  # GET /storekeepers/new.json
  def new
    @storekeeper = Storekeeper.new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @storekeeper }
    end
  end

  # GET /storekeepers/1/edit
  def edit
    @storekeeper = Storekeeper.find(params[:id])
  end

  # POST /storekeepers
  # POST /storekeepers.json
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
  # PUT /storekeepers/1.json
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
  def destroy
    @storekeeper = Storekeeper.find(params[:id])
    @storekeeper.destroy

    respond_to do |format|
      format.html { redirect_to storekeepers_url }
      format.json { head :no_content }
    end
  end
end
