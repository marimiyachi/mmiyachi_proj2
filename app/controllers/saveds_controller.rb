class SavedsController < ApplicationController
  # GET /saveds
  # GET /saveds.json
  def index
    @saveds = Saved.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @saveds }
    end
  end

  # GET /saveds/1
  # GET /saveds/1.json
  def show
    @saved = Saved.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @saved }
    end
  end

  # GET /saveds/new
  # GET /saveds/new.json
  def new
    @saved = Saved.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @saved }
    end
  end

  # GET /saveds/1/edit
  def edit
    @saved = Saved.find(params[:id])
  end

  # remove from saved
  # add back to cart
  def add_cart
    @saved = Saved.find(params[:id])
    @cart = Cart.find_by_storekeeper_id(current_storekeeper.id)
    @item = Item.find_by_id(@saved.item_id)
    @cart.add_item(@item)
    @saved.destroy
  end

  # POST /saveds
  # POST /saveds.json
  def create
    @saved = Saved.new(params[:saved])

    respond_to do |format|
      if @saved.save
        format.html { redirect_to @saved, notice: 'Saved was successfully created.' }
        format.json { render json: @saved, status: :created, location: @saved }
      else
        format.html { render action: "new" }
        format.json { render json: @saved.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /saveds/1
  # PUT /saveds/1.json
  def update
    @saved = Saved.find(params[:id])

    respond_to do |format|
      if @saved.update_attributes(params[:saved])
        format.html { redirect_to @saved, notice: 'Saved was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @saved.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saveds/1
  # DELETE /saveds/1.json
  def destroy
    @saved = Saved.find(params[:id])
    @saved.destroy

    respond_to do |format|
      format.html { redirect_to saveds_url }
      format.json { head :no_content }
    end
  end
end
