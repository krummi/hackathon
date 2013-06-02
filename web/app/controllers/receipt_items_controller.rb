class ReceiptItemsController < ApplicationController
  # GET /receipt_items
  # GET /receipt_items.json
  def index
    @receipt_items = ReceiptItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @receipt_items }
    end
  end

  # GET /receipt_items/1
  # GET /receipt_items/1.json
  def show
    @receipt_item = ReceiptItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @receipt_item }
    end
  end

  # GET /receipt_items/new
  # GET /receipt_items/new.json
  def new
    @receipt_item = ReceiptItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @receipt_item }
    end
  end

  # GET /receipt_items/1/edit
  def edit
    @receipt_item = ReceiptItem.find(params[:id])
  end

  # POST /receipt_items
  # POST /receipt_items.json
  def create
    @receipt_item = ReceiptItem.new(params[:receipt_item])

    respond_to do |format|
      if @receipt_item.save
        format.html { redirect_to @receipt_item, notice: 'Receipt item was successfully created.' }
        format.json { render json: @receipt_item, status: :created, location: @receipt_item }
      else
        format.html { render action: "new" }
        format.json { render json: @receipt_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /receipt_items/1
  # PUT /receipt_items/1.json
  def update
    @receipt_item = ReceiptItem.find(params[:id])

    respond_to do |format|
      if @receipt_item.update_attributes(params[:receipt_item])
        format.html { redirect_to @receipt_item, notice: 'Receipt item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @receipt_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipt_items/1
  # DELETE /receipt_items/1.json
  def destroy
    @receipt_item = ReceiptItem.find(params[:id])
    @receipt_item.destroy

    respond_to do |format|
      format.html { redirect_to receipt_items_url }
      format.json { head :no_content }
    end
  end
end
